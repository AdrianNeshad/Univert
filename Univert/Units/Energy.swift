//
//  Energy.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-08.
//

import SwiftUI

struct Energi: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "J"
    @State private var selectedToUnit: String? = "J"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false

    let unitName = "Energi"
    
    let units = ["J", "kJ", "kWh", "Wh", "cal", "kcal", "Btu"]
    
    let fullNames: [String: String] = [
            "J": "Joule",
            "kJ": "Kilojoule",
            "kWh": "Kilowatt-hour",
            "Wh": "Watt-hour",
            "cal": "Calorie",
            "kcal": "Kilocalorie",
            "Btu": "British Thermal Unit"
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
        .navigationTitle("Energi")
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
    
    func convertEnergy(value: Double, fromUnit: String, toUnit: String) -> Double? {
            let conversionFactors: [String: Double] = [
                "J": 1,           // Joule (basenhet)
                "kJ": 1000,       // 1 kJ = 1000 J
                "kWh": 3600000, // 1 kWh = 3,600,000 J
                "Wh": 3600,       // 1 Wh = 3600 J
                "cal": 4.184,     // 1 cal = 4.184 J
                "kcal": 4184,     // 1 kcal = 4184 J
                "Btu": 1055.06    // 1 Btu = 1055.06 J
            ]
            
            // Kontrollera att enheterna finns i conversionFactors
            guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
                return nil // Om någon enhet inte finns i listan, returnera nil
            }

            // Omvandla till Joule (basenhet)
            let valueInJoules = value * fromFactor
            
            // Omvandla från Joule till mål-enheten
            let convertedValue = valueInJoules / toFactor
            return convertedValue
        }
    
    func updateOutputValue(inputDouble: Double) {
        if let result = convertEnergy(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 4)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }


}

