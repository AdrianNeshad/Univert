//
//  Currency.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-07.
//

import SwiftUI
import AlertToast

struct ExchangeResponse: Codable {
    let rates: [String: Double]
    let base: String
    let date: String
}

struct Valuta: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("clipboardUnit") private var clipboardUnit = false
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFromUnit: String? = "USD"
    @State private var selectedToUnit: String? = "USD"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    let unitId = "currency"
    
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
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        VStack {
            ZStack {
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
                    .onChange(of: selectedFromUnit) { _ in
                        outputValue = ""
                        fetchExchangeRates()
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
                    .onChange(of: selectedToUnit) { _ in
                        updateOutput()
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
                                    Text("\(unit) - \(currencyNames[unit] ?? "")")
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
                                    Text("\(unit) - \(currencyNames[unit] ?? "")")
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
                Text("(\(selectedFromUnit ?? "")) \(currencyNames[selectedFromUnit ?? ""] ?? "")")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("(\(selectedToUnit ?? "")) \(currencyNames[selectedToUnit ?? ""] ?? "")")
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
                        .onChange(of: inputValue) { _ in
                            updateOutput()
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
                Text(StringManager.shared.get("source"))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        
        Spacer()
        .navigationTitle(StringManager.shared.get("unit_currency"))
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
                    updateOutput()
                }
            } catch {
                print("Fel vid JSON-parsing: \(error)")
            }
        }.resume()
    }
 
    func updateOutput() {
        let normalizedValue = inputValue.replacingOccurrences(of: ",", with: ".")
        guard let inputDouble = Double(normalizedValue),
              let toRate = exchangeRates[selectedToUnit ?? ""] else {
            outputValue = ""
            return
        }
        
        let convertedValue = inputDouble * toRate
        outputValue = FormatterHelper.shared.formatResult(convertedValue, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
    }
    
    private func swapUnits() {
        let tempUnit = selectedFromUnit
        selectedFromUnit = selectedToUnit
        selectedToUnit = tempUnit
        updateOutput()
        feedbackGenerator.impactOccurred()
        feedbackGenerator.prepare()
    }
}
