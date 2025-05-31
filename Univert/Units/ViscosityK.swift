//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct ViskositetK: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "m²/s"
    @State private var selectedToUnit: String? = "m²/s"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    
    let unitId = "viscosity_kinematic"
    
    let units = ["m²/s", "m²/h", "cm²/s", "mm²/s", "ft²/s", "ft²/h", "in²/s", "St", "ESt", "PSt", "TSt", "GSt", "MSt", "kSt", "hSt", "daSt", "dSt", "cSt", "mSt", "µSt", "nSt", "pSt", "fSt", "aSt"]

    let fullNames: [String: String] = [
        "m²/s": "Square meter per second",
        "m²/h": "Square meter per hour",
        "cm²/s": "Square centimeter per second",
        "mm²/s": "Square millimeter per second",
        "ft²/s": "Square foot per second",
        "ft²/h": "Square foot per hour",
        "in²/s": "Square inch per second",
        "St": "Stokes",
        "ESt": "Exastokes",
        "PSt": "Petastokes",
        "TSt": "Terastokes",
        "GSt": "Gigastokes",
        "MSt": "Megastokes",
        "kSt": "Kilostokes",
        "hSt": "Hectostokes",
        "daSt": "Dekastokes",
        "dSt": "Decistokes",
        "cSt": "Centistokes",
        "mSt": "Millistokes",
        "µSt": "Microstokes",
        "nSt": "Nanostokes",
        "pSt": "Picostokes",
        "fSt": "Femtostokes",
        "aSt": "Attostokes"
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
        .navigationTitle(appLanguage == "sv" ? "Viskositet (kinematisk)" : "Viscosity (kinematic)")
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

    func convertViscosityK(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "m²/s": 1.0,
            "m²/h": 0.0002777778,
            "cm²/s": 0.0001,
            "mm²/s": 1.0E-6,
            "ft²/s": 0.09290304,
            "ft²/h": 2.58064E-5,
            "in²/s": 0.00064516,
            "St": 0.0001,
            "ESt": 1.0E+14,
            "PSt": 1.0E+11,
            "TSt": 1.0E+8,
            "GSt": 1.0E+5,
            "MSt": 100.0,
            "kSt": 0.1,
            "hSt": 0.01,
            "daSt": 0.001,
            "dSt": 1.0E-5,
            "cSt": 1.0E-6,
            "mSt": 1.0E-7,
            "µSt": 1.0E-10,
            "nSt": 1.0E-13,
            "pSt": 1.0E-16,
            "fSt": 1.0E-19,
            "aSt": 1.0E-22
        ]

          guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
              return nil
          }
          let valueInBaseUnit = value * fromFactor
          let convertedValue = valueInBaseUnit / toFactor
          return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertViscosityK(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }
}

