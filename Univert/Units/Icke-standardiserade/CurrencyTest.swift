//
//  CurrencyTest.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-07.
//

import SwiftUI
import AlertToast

struct ExchangeResponse2: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}

struct Krypto: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("clipboardUnit") private var clipboardUnit = false
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFromUnit: String? = "BTC"
    @State private var selectedToUnit: String? = "BTC"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    let unitId = "crypto_beta"
    
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
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("►")
                        .font(.title)
                        .frame(width: 50)
                    PomodoroPicker(selection: $selectedFromUnit, options: units) { unit in
                        Text(unit)
                            .font(.title)
                            .bold()
                            .frame(width: 100)
                            .padding(.leading, -90)
                    }
                    PomodoroPicker(selection: $selectedToUnit, options: units) { unit in
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
                .padding(.top, 80)
                
                VStack {
                    HStack {
                        Menu {
                            ForEach(units, id: \.self) { unit in
                                Button {
                                    selectedFromUnit = unit
                                    feedbackGenerator.impactOccurred()
                                    feedbackGenerator.prepare()
                                } label: {
                                    Text("\(unit) - \(fullNames[unit] ?? "")")
                                }
                            }
                        } label: {
                            Text(StringManager.shared.get("from"))
                                .foregroundColor(.primary)
                                .font(.title)
                                .bold()
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Button(action: swapUnits) {
                            Image("univert.svg")
                                .resizable()
                                .frame(width: 50, height: 40)
                        }
                        Menu {
                            ForEach(units, id: \.self) { unit in
                                Button {
                                    selectedToUnit = unit
                                    feedbackGenerator.impactOccurred()
                                    feedbackGenerator.prepare()
                                } label: {
                                    Text("\(unit) - \(fullNames[unit] ?? "")")
                                }
                            }
                        } label: {
                            Text(StringManager.shared.get("to"))
                                .foregroundColor(.primary)
                                .font(.title)
                                .bold()
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal, 50)
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
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
                    TextField(StringManager.shared.get("value"), text: $inputValue)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(10)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(colorScheme == .dark ? Color.gray.opacity(0.35) : Color.gray.opacity(0.2))
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

                    HStack(spacing: 5) {
                        Text(outputValue)
                            .padding(10)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textSelection(.enabled)

                        if !outputValue.isEmpty {
                            Button(action: {
                                UIPasteboard.general.string = clipboardUnit ? "\(outputValue) \(selectedToUnit ?? "")" : outputValue
                                toastMessage = StringManager.shared.get("copied")
                                toastIcon = "doc.on.doc"
                                toastColor = .green
                                withAnimation { showToast = true }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation { showToast = false }
                                }
                            }) {
                                Image(systemName: "doc.on.doc")
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                    .padding(10)
                    .frame(height: 50)
                    .background(colorScheme == .dark ? Color.gray.opacity(0.35) : Color.gray.opacity(0.2))
                    .cornerRadius(5)
                }
                Text(StringManager.shared.get("source2"))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        
        Spacer()
        .navigationTitle(StringManager.shared.get("unit_crypto_beta"))
        .padding()
        .onAppear {
            fetchExchangeRates()
            
            if let data = savedUnitsData,
               let savedUnits = try? JSONDecoder().decode([Units].self, from: data) {
                currentUnits = savedUnits
            } else {
                currentUnits = Units.preview()
            }
            
            if let match = currentUnits.first(where: { $0.id == unitId }) {
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
                .toast(isPresenting: $showToast) {
                    AlertToast(displayMode: .hud, type: .systemImage(toastIcon, toastColor), title: toastMessage)
                }
    }
    func toggleFavorite() {
        if let index = currentUnits.firstIndex(where: { $0.id == unitId }) {
            currentUnits[index].isFavorite.toggle()
            isFavorite = currentUnits[index].isFavorite

            if let data = try? JSONEncoder().encode(currentUnits) {
                savedUnitsData = data
            }

            if isFavorite {
                toastMessage = StringManager.shared.get("addedtofavorites")
                toastIcon = "star.fill"
                toastColor = .yellow
            } else {
                toastMessage = StringManager.shared.get("removed")
                toastIcon = "star"
                toastColor = .gray
            }

            withAnimation {
                showToast = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showToast = false
                }
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
            outputValue = "Error"
            return
        }

        let valueInUSD = inputDouble * fromRate
        let convertedValue = valueInUSD / toRate

        outputValue = FormatterHelper.shared.formatResult(convertedValue, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 8)
    }
    
    private func swapUnits() {
            let tempUnit = selectedFromUnit
            selectedFromUnit = selectedToUnit
            selectedToUnit = tempUnit
            outputValue = ""
            feedbackGenerator.impactOccurred()
            feedbackGenerator.prepare()
        }
}
