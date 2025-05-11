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
    
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false

    let unitName = "Hastighet"
    
    let units = ["km/h", "mph", "m/s", "knot", "km/min", "m/min", "m/h", "km/s", "ft/s", "ft/min"]
    
    let fullNames: [String: String] = [
        "km/h": "Kilometer per hour",
        "mph": "Miles per hour",
        "m/s": "Meters per second",
        "knot": "Knots",
        "km/min": "Kilometers per minute",
        "m/min": "Meters per minute",
        "m/h": "Meters per hour",
        "km/s": "Kilometers per second",
        "ft/s": "Feet per second",
        "ft/min": "Feet per minute"
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
        .navigationTitle("Hastighet")
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
    
    func convertVelocity(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "km/h": 1, // basenhet
            "mph": 1.60934, // miles per hour till kilometer per timme
            "m/s": 3.6, // meter per sekund till kilometer per timme
            "m/min": 0.06, // meter per minut till kilometer per timme
            "m/h": 0.001, // meter per timme till kilometer per timme
            "km/s": 3600, // kilometer per sekund till kilometer per timme
            "km/min": 60, // kilometer per minut till kilometer per timme
            "ft/s": 1.09728, // fot per sekund till kilometer per timme
            "ft/min": 0.018287, // fot per minut till kilometer per timme
            "knot": 1.852, // knoten till kilometer per timme
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
