//
//  CurrencyTest.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-07.
//

import SwiftUI

struct ExchangeResponse2: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}

struct Krypto: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "BTC"
    @State private var selectedToUnit: String? = "BTC"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["BTC", "USD", "ETH"]
    
    let fullNames: [String: String] = [
        "BTC": "Bitcoin",
        "USD": "US Dollar",
        "ETH": "Ethereum"
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
                Text("(\(selectedFromUnit ?? "")) \(fullNames[selectedFromUnit ?? ""] ?? "")")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("(\(selectedToUnit ?? "")) \(fullNames[selectedToUnit ?? ""] ?? "")")
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
                        let normalizedValue = useSwedishDecimal ? newValue.replacingOccurrences(of: ",", with: ".") : newValue
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
                        let normalizedValue = useSwedishDecimal ? inputValue.replacingOccurrences(of: ",", with: ".") : inputValue
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
        .navigationTitle("Krypto")
        .padding()
        .onAppear {
            fetchExchangeRates()
        }
    }
    
    func fetchExchangeRates() {
        let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=usd")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let bitcoinData = json["bitcoin"] as? [String: Any],
                           let ethereumData = json["ethereum"] as? [String: Any] {
                            DispatchQueue.main.async {
                                self.exchangeRates["USD"] = 1
                                self.exchangeRates["BTC"] = bitcoinData["usd"] as? Double
                                self.exchangeRates["ETH"] = ethereumData["usd"] as? Double
                                
                                let normalizedValue = useSwedishDecimal ? self.inputValue.replacingOccurrences(of: ",", with: ".") : self.inputValue
                                if let inputDouble = Double(normalizedValue) {
                                    self.updateOutputValue(inputDouble: inputDouble)
                                }
                            }
                        }
                    }
                } catch {
                    print("Fel vid JSON-parsing")
                }
            }
        }.resume()
    }

    func updateOutputValue(inputDouble: Double) {
        guard let fromRate = exchangeRates[selectedFromUnit ?? ""],
              let toRate = exchangeRates[selectedToUnit ?? ""] else {
            outputValue = "Ogiltig enhet"
            return
        }

        let valueInUSD = inputDouble * fromRate
        let convertedValue = valueInUSD / toRate

        outputValue = FormatterHelper.shared.formatResult(convertedValue, useSwedishDecimal: useSwedishDecimal)
    }
}
