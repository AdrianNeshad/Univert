//
//  Currency.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-07.
//

import SwiftUI

struct ExchangeResponse: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}

struct Valuta: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "USD"
    @State private var selectedToUnit: String? = "USD"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["USD", "EUR", "SEK", "GBP", "AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "HKD", "HUF", "IDR", "ILS", "INR", "ISK", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "SGD", "THB", "TRY", "ZAR"]
    
    let currencyNames: [String: String] = [
        "USD": "US Dollar",
        "EUR": "Euro",
        "SEK": "Swedish Krona",
        "GBP": "British Pound",
        "AUD": "Australian Dollar",
        "BGN": "Bulgarian Lev",
        "BRL": "Brazilian Real",
        "CAD": "Canadian Dollar",
        "CHF": "Swiss Franc",
        "CNY": "Chinese Yuan",
        "CZK": "Czech Koruna",
        "DKK": "Danish Krone",
        "HKD": "Hong Kong Dollar",
        "HUF": "Hungarian Forint",
        "IDR": "Indonesian Rupiah",
        "ILS": "Israeli New Shekel",
        "INR": "Indian Rupee",
        "ISK": "Icelandic Króna",
        "JPY": "Japanese Yen",
        "KRW": "South Korean Won",
        "MXN": "Mexican Peso",
        "MYR": "Malaysian Ringgit",
        "NOK": "Norwegian Krone",
        "NZD": "New Zealand Dollar",
        "PHP": "Philippine Peso",
        "PLN": "Polish Zloty",
        "RON": "Romanian Leu",
        "SGD": "Singapore Dollar",
        "THB": "Thai Baht",
        "TRY": "Turkish Lira",
        "ZAR": "South African Rand"
    ]
    
    @State private var exchangeRates: [String: Double] = [:]
    
    var body: some View {
        VStack {
            HStack {
                Text("Från")
                    .font(.title)
                    .bold()
                    .padding(10)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                
                Text("➤")
                    .font(.title)
                    .bold()
                    .frame(width: 100)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)

                Text("Till")
                    .font(.title)
                    .bold()
                    .padding(10)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
            }
            
            HStack {
                Text("►")
                    .font(.title)
                    .frame(width: 50)
                
                PomodoroPicker(
                    selection: $selectedFromUnit,
                    options: units
                ) { unit in
                    Text(unit)
                        .font(.title)
                        .bold()
                        .frame(width: 100)
                        .padding(.leading, -90)
                }
                
                PomodoroPicker(
                    selection: $selectedToUnit,
                    options: units
                ) { unit in
                    Text(unit)
                        .font(.title)
                        .bold()
                        .frame(width: 100)
                        .padding(.trailing, -90)
                }
                
                Text("◄")
                    .font(.title)
                    .frame(width: 50)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            
            HStack {
                Text("(\(selectedFromUnit ?? "")) \(currencyNames[selectedFromUnit ?? ""] ?? "")")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("(\(selectedToUnit ?? "")) \(currencyNames[selectedToUnit ?? ""] ?? "")")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 0)
            }
            
            HStack(spacing: 10) {
                TextField("Värde", text: $inputValue)
                                    .keyboardType(.decimalPad)
                                    .padding(10)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(5)
                                    .multilineTextAlignment(.leading)
                                    .onChange(of: inputValue) { newValue in
                                        var updatedValue = newValue
                                        if !useSwedishDecimal {
                                            let replaced = newValue.replacingOccurrences(of: ",", with: ".")
                                            if replaced != newValue {
                                                updatedValue = replaced
                                                inputValue = replaced
                                            }
                                        }
                                        
                                        let normalizedValue = updatedValue.replacingOccurrences(of: ",", with: ".")
                                        if let inputDouble = Double(normalizedValue) {
                                            updateOutputValue(inputDouble: inputDouble)
                                        } else {
                                            outputValue = ""
                                        }
                                    }
                                    .onChange(of: selectedFromUnit) { _ in
                                        fetchExchangeRates()
                                    }
                                    .onChange(of: selectedToUnit) { _ in
                                        let normalizedValue = inputValue.replacingOccurrences(of: ",", with: ".")
                                        if let inputDouble = Double(normalizedValue) {
                                            updateOutputValue(inputDouble: inputDouble)
                                        }
                                    }
                
                Text(outputValue.isEmpty ? "" : outputValue)
                    .padding(10)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        
        Spacer()
        .navigationTitle("Valuta")
        .padding()
        .onAppear {
            fetchExchangeRates()
        }
    }
    
    func fetchExchangeRates() {
        guard let fromUnit = selectedFromUnit else { return }
        let urlString = "https://api.frankfurter.app/latest?from=\(fromUnit)"
        
        guard let url = URL(string: urlString) else {
            print("Ogiltig URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fel vid hämtning: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Ingen data")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(ExchangeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.exchangeRates = decoded.rates
                    self.exchangeRates[fromUnit] = 1.0
                    print("Hämtade växelkurser: \(self.exchangeRates)")
                    
                    let normalizedValue = self.inputValue.replacingOccurrences(of: ",", with: ".")
                    if let inputDouble = Double(normalizedValue) {
                        self.updateOutputValue(inputDouble: inputDouble)
                    }
                }
            } catch {
                print("Fel vid JSON-parsing: \(error)")
            }
        }.resume()
    }
 
    func updateOutputValue(inputDouble: Double) {
        guard let toRate = exchangeRates[selectedToUnit ?? ""] else {
            outputValue = "Ogiltig enhet"
            return
        }
        
        let convertedValue = inputDouble * toRate
        outputValue = FormatterHelper.shared.formatResult(convertedValue, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
    }
}
