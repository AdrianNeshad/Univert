//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct Andelar: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "%"
    @State private var selectedToUnit: String? = "%"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @AppStorage("appLanguage") private var appLanguage = "sv" // default: svenska

    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false

    let unitName = "Andelar"

    
    let units = ["%", "mg/Kg", "mg/g", "g/Kg", "ug/Kg", "ug/g", "ppm", "ppb", "ppt", "pptr", "ppth", "ppq", "pg/g", "ng/g", "ng/Kg"]
        
        let fullNames: [String: String] = [
            "%": "Percent",
            "mg/Kg": "Milligram per Kilogram",
            "mg/g": "Milligram per Gram",
            "g/Kg": "Gram per Kilogram",
            "ug/Kg": "Microgram per Kilogram",
            "ug/g": "Microgram per Gram",
            "ppm": "Parts Per Million",
            "ppb": "Parts Per Billion",
            "ppt": "Parts Per Trillion",
            "pptr": "Parts Per Trillion (pptr)",
            "ppth": "Parts Per Thousand (ppth)",
            "ppq": "Parts Per Quadrillion (ppq)",
            "pg/g": "Picogram per Gram",
            "ng/g": "Nanogram per Gram",
            "ng/Kg": "Nanogram per Kilogram"
        ]
    
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
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle("Andelar")
        .padding()
        .onAppear {
            if let data = savedUnitsData,
               let savedUnits = try? JSONDecoder().decode([Units].self, from: data),
               let match = savedUnits.first(where: { $0.name == unitName }) {
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
        var currentUnits = Units.preview()
        
        // Ladda in sparade favoritstatusar
        if let data = savedUnitsData,
           let savedUnits = try? JSONDecoder().decode([Units].self, from: data) {
            for i in 0..<currentUnits.count {
                if let saved = savedUnits.first(where: { $0.name == currentUnits[i].name }) {
                    currentUnits[i].isFavorite = saved.isFavorite
                }
            }
        }
        
        // Toggla favoritstatus för "Andelar"
        if let index = currentUnits.firstIndex(where: { $0.name == unitName }) {
            currentUnits[index].isFavorite.toggle()
            isFavorite = currentUnits[index].isFavorite
            
            if let data = try? JSONEncoder().encode(currentUnits) {
                savedUnitsData = data
            }
        }
    }

    
    func convertShares(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "%": 1.0,                // 1% = 1% (identitet)
            "mg/Kg": 0.0001,         // 1 mg/Kg = 1 ppm = 0.0001%
            "mg/g": 0.1,             // 1 mg/g = 1000 ppm = 0.1%
            "g/Kg": 0.1,             // 1 g/Kg = 1000 mg/Kg = 0.1%
            "ug/Kg": 1e-7,           // 1 µg/Kg = 1 ppb = 0.0000001%
            "ug/g": 0.0001,          // 1 µg/g = 1 ppm = 0.0001%
            "ppm": 0.0001,           // 1 ppm = 0.0001%
            "ppb": 1e-7,             // 1 ppb = 0.0000001%
            "ppt": 1e-10,            // 1 ppt = 0.0000000001%
            "pptr": 1e-10,           // 1 pptr = 1 ppt = 0.0000000001%
            "ppth": 0.1,             // 1 ppth = 0.1% (per thousand)
            "ppq": 1e-13,            // 1 ppq = 0.0000000000001%
            "pg/g": 1e-10,           // 1 pg/g = 1 ppt = 0.0000000001%
            "ng/g": 0.0001,          // 1 ng/g = 1 ppm = 0.0001%
            "ng/Kg": 1e-7            // 1 ng/Kg = 1 ppb = 0.0000001%
        ]
        
        // Kontrollera att enheterna finns
        guard let fromFactor = conversionFactors[fromUnit],
              let toFactor = conversionFactors[toUnit] else {
            return nil
        }
        
        // Omvandla till procent (basenhet)
        let valueInPercent = value * fromFactor
        
        // Omvandla från procent till mål-enhet
        let convertedValue = valueInPercent / toFactor
        
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertShares(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 4)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }


}
