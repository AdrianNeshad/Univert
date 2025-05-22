//
//  Velocity.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Hastighet: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "km/h"
    @State private var selectedToUnit: String? = "km/h"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @AppStorage("appLanguage") private var appLanguage = "en" 

    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []

    let unitName = "Hastighet"
    
    let units = [
        "m/s", "km/h", "mph", "m/h", "m/min", "knot", "km/min", "km/s",
        "cm/h", "cm/min", "cm/s", "mm/h", "mm/min", "mm/s",
        "ft/h", "ft/min", "ft/s", "yd/h", "yd/min", "yd/s",
        "mi/min", "mi/s", "kn(UK)", "c", "v1", "v2", "v3",
        "vE", "vs(w)", "vs(sw)", "M", "M(SI)"
    ]

    
    let fullNames: [String: String] = [
        "m/s": "meter/second",
        "km/h": "kilometer/hour",
        "mph": "mile/hour",
        "m/h": "meter/hour",
        "m/min": "meter/minute",
        "km/min": "kilometer/minute",
        "km/s": "kilometer/second",
        "cm/h": "centimeter/hour",
        "cm/min": "centimeter/minute",
        "cm/s": "centimeter/second",
        "mm/h": "millimeter/hour",
        "mm/min": "millimeter/minute",
        "mm/s": "millimeter/second",
        "ft/h": "foot/hour",
        "ft/min": "foot/minute",
        "ft/s": "foot/second",
        "yd/h": "yard/hour",
        "yd/min": "yard/minute",
        "yd/s": "yard/second",
        "mi/min": "mile/minute",
        "mi/s": "mile/second",
        "knot": "knot",
        "kn(UK)": "knot (UK)",
        "c": "Velocity of light in vacuum",
        "v1": "Cosmic velocity - first",
        "v2": "Cosmic velocity - second",
        "v3": "Cosmic velocity - third",
        "vE": "Earth's velocity",
        "vs(w)": "Velocity of sound in pure water",
        "vs(sw)": "Velocity of sound in sea water",
        "M": "Mach (20°C, 1 atm)",
        "M(SI)": "Mach (SI standard)"
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
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle(appLanguage == "sv" ? "Hastighet" : "Speed")
        .padding()
        .onAppear {
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

    
    func convertVelocity(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "km/h": 1.0,
            "mph": 1.60934,
            "m/s": 3.6,
            "m/min": 0.06,
            "m/h": 0.001,
            "km/s": 3600.0,
            "km/min": 60.0,
            "cm/h": 0.00001,
            "cm/min": 0.0006,
            "cm/s": 0.036,
            "mm/h": 0.000001,
            "mm/min": 0.00006,
            "mm/s": 0.0036,
            "ft/h": 0.0003048,
            "ft/min": 0.018287,
            "ft/s": 1.09728,
            "yd/h": 0.0009144,
            "yd/min": 0.054864,
            "yd/s": 3.29184,
            "mi/min": 96.5604,
            "mi/s": 5793.62,
            "knot": 1.852,
            "kn(UK)": 1.85328,
            "c": 1.079e+9,
            "v1": 28.44,
            "v2": 39.87,
            "v3": 52.0,
            "vE": 107218,
            "vs(w)": 5.4,
            "vs(sw)": 5.35,
            "M": 1225.044,
            "M(SI)": 1234.8
        ]

        
        // Kontrollera att enheterna finns i conversionFactors
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
            return nil // Om någon enhet inte finns i listan, returnera nil
        }

        // Omvandla till kilometer per timme (basenhet)
        let valueInKmPerHour = value * fromFactor
        
        // Omvandla från kilometer per timme till mål-enhet
        let convertedValue = valueInKmPerHour / toFactor
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertVelocity(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }


}
