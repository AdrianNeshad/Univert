//
//  Time.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Tid: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "ms"
    @State private var selectedToUnit: String? = "ms"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @AppStorage("appLanguage") private var appLanguage = "en"

    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    
    let unitId = "time"
    
    let units = ["ms", "s", "min", "h", "d", "w", "m", "yr"]
    
    let fullNames: [String: String] = [
        "ms": "Millisecond",
        "s": "Second",
        "min": "Minute",
        "h": "Hour",
        "d": "Day",
        "w": "Week",
        "m": "Month",
        "yr": "Year"
    ]
    
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
                            Text("(\(selectedFromUnit ?? "")) \(fullNames[selectedFromUnit ?? ""] ?? "")")  // Visa både valutakod och fullständigt namn
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            Text("(\(selectedToUnit ?? "")) \(fullNames[selectedToUnit ?? ""] ?? "")")  // Visa både valutakod och fullständigt namn
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 0)
                        }
            
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
                    .textSelection(.enabled)
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle(appLanguage == "sv" ? "Tid" : "Time")
        .padding()
        .onAppear {
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
    }
    func toggleFavorite() {
        if let index = currentUnits.firstIndex(where: { $0.id == unitId }) {
            currentUnits[index].isFavorite.toggle()
            isFavorite = currentUnits[index].isFavorite
            
            if let data = try? JSONEncoder().encode(currentUnits) {
                savedUnitsData = data
            }
        }
    }
    
    func convertTime(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "s": 1, // basenhet (sekunder)
            "ms": 0.001, // millisekunder till sekunder
            "min": 60, // minuter till sekunder
            "h": 3600, // timmar till sekunder
            "d": 86400, // dagar till sekunder
            "w": 604800, // veckor till sekunder
            "m": 2592000, // månad (genomsnittlig månad) till sekunder
            "yr": 31536000 // år till sekunder (genomsnittligt år)
        ]
        
        // Kontrollera att enheterna finns i conversionFactors
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
            return nil // Om någon enhet inte finns i listan, returnera nil
        }

        // Omvandla till sekunder (basenhet)
        let valueInSeconds = value * fromFactor
        
        // Omvandla från sekunder till mål-enhet
        let convertedValue = valueInSeconds / toFactor
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertTime(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 4)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }


}
