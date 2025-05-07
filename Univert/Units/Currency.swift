//
//  Currency.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-07.
//

import SwiftUI

struct Valuta: View {
    @State private var selectedFromUnit: String? = "BTC"
    @State private var selectedToUnit: String? = "BTC"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["BTC", "ETH", "USD"]
    
    @State private var exchangeRates: [String: Double] = [:]

    var body: some View {
        VStack {
            HStack {
                Text("Från")
                    .font(.title)
                    .bold()
                    .textFieldStyle(PlainTextFieldStyle())
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
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
            } //HStack
            
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
            } //HStack
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            
            HStack {
                Text("(\(selectedFromUnit ?? ""))")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("(\(selectedToUnit ?? ""))")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 0)
            } //HStack
            
            HStack(spacing: 10) {
                TextField("Värde", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
                    .onChange(of: inputValue) { newValue in
                        // Omvandla komma till punkt och försök att konvertera till Double
                        let formattedValue = newValue.replacingOccurrences(of: ",", with: ".")
                        if let inputDouble = Double(formattedValue) {
                            updateOutputValue(inputDouble: inputDouble)
                        } else {
                            outputValue = ""
                        }
                    }
                    .onChange(of: selectedFromUnit) { _ in
                        // Uppdatera output när enheten ändras
                        if let inputDouble = Double(inputValue) {
                            updateOutputValue(inputDouble: inputDouble)
                        }
                    }
                    .onChange(of: selectedToUnit) { _ in
                        // Uppdatera output när enheten ändras
                        if let inputDouble = Double(inputValue) {
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
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle("Valuta")
        .padding()
        
        .onAppear {
                    fetchExchangeRates() // Hämta växelkurser när vyn visas
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
                                    self.exchangeRates["BTC"] = bitcoinData["usd"] as? Double
                                    self.exchangeRates["ETH"] = ethereumData["usd"] as? Double
                                    self.exchangeRates["USD"] = 1 // USD är basenhet, så dess kurs är alltid 1
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

            // Konvertera till USD basenhet
            let valueInUSD = inputDouble * fromRate

            // Konvertera från USD till den valda mål-enheten
            let convertedValue = valueInUSD / toRate
            let formattedResult = String(format: "%.2f", convertedValue)
            outputValue = formattedResult
        }
}
