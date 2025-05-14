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
    @AppStorage("appLanguage") private var appLanguage = "sv" // default: svenska

    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    
    let unitName = "Krypto"
    
    let units = ["BTC", "USD", "ETH", "BNB", "SOL", "XRP", "ADA", "DOGE"]
       
       let fullNames: [String: String] = [
           "BTC": "Bitcoin",
           "USD": "US Dollar",
           "ETH": "Ethereum",
           "BNB": "Binance Coin",
           "SOL": "Solana",
           "XRP": "XRP",
           "ADA": "Cardano",
           "DOGE": "Dogecoin",
       ]
    @State private var exchangeRates: [String: Double] = [:]
    
    var body: some View {
        VStack {
            HStack {
                Text(appLanguage == "sv" ? "Från" : "From")
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

                Text(appLanguage == "sv" ? "Till" : "To")
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
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 10) {
                    TextField(appLanguage == "sv" ? "Värde" : "Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
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
                            let normalizedValue = inputValue.replacingOccurrences(of: ",", with: ".")
                            if let inputDouble = Double(normalizedValue) {
                                updateOutputValue(inputDouble: inputDouble)
                            }
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
                Text(appLanguage == "sv" ? "Källa: CoinGecko" : "Source: CoinGecko")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        
        Spacer()
        .navigationTitle(appLanguage == "sv" ? "Krypto (beta)" : "Crypto (beta)")
        .padding()
        .onAppear {
            fetchExchangeRates()
            
            if let data = savedUnitsData,
               let savedUnits = try? JSONDecoder().decode([Units].self, from: data) {
                currentUnits = savedUnits
            } else {
                currentUnits = Units.preview()
            }
            
            if let match = currentUnits.first(where: { $0.name == unitName }) {
                isFavorite = match.isFavorite
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
            }
        }
    }
    
    func toggleFavorite() {
        if let index = currentUnits.firstIndex(where: { $0.name == unitName }) {
            currentUnits[index].isFavorite.toggle()
            isFavorite = currentUnits[index].isFavorite
            
            if let data = try? JSONEncoder().encode(currentUnits) {
                savedUnitsData = data
            }
        }
    }
    
    func fetchExchangeRates() {
        let url = URL(string: "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,binancecoin,solana,ripple,cardano,dogecoin&vs_currencies=usd")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let bitcoinData = json["bitcoin"] as? [String: Any],
                           let ethereumData = json["ethereum"] as? [String: Any],
                            let binancecoinData = json["binancecoin"] as? [String: Any],
                            let solanaData = json["solana"] as? [String: Any],
                            let rippleData = json["ripple"] as? [String: Any],
                            let cardanoData = json["cardano"] as? [String: Any],
                            let dogecoinData = json["dogecoin"] as? [String: Any]
                        {
                            DispatchQueue.main.async {
                                self.exchangeRates["USD"] = 1
                                self.exchangeRates["BTC"] = bitcoinData["usd"] as? Double
                                self.exchangeRates["ETH"] = ethereumData["usd"] as? Double
                                self.exchangeRates["BNB"] = binancecoinData["usd"] as? Double
                                self.exchangeRates["SOL"] = solanaData["usd"] as? Double
                                self.exchangeRates["XRP"] = rippleData["usd"] as? Double
                                self.exchangeRates["ADA"] = cardanoData["usd"] as? Double
                                self.exchangeRates["DOGE"] = dogecoinData["usd"] as? Double
                       
                                let normalizedValue = self.inputValue.replacingOccurrences(of: ",", with: ".")
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

        outputValue = FormatterHelper.shared.formatResult(convertedValue, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 8)
    }
}
