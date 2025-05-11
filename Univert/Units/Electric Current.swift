//
//  Electric Current.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-11.
//

import SwiftUI

struct ElektriskStröm: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "A"
    @State private var selectedToUnit: String? = "A"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @AppStorage("appLanguage") private var appLanguage = "sv" // default: svenska

    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false

    let unitName = "Elektrisk ström"
    
    let units = ["A", "kA", "mA", "Bi", "abA", "emuI", "statA", "esuI", "CGSem", "CGSes"]

    let fullNames: [String: String] = [
        "A": "ampere",
        "kA": "kiloampere",
        "mA": "milliampere",
        "Bi": "biot",
        "abA": "abampere",
        "emuI": "EMU of current",
        "statA": "statampere",
        "esuI": "ESU of current",
        "CGSem": "CGS e.m. unit",
        "CGSes": "CGS e.s. unit"
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
        .navigationTitle("Elektrisk ström")
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
    
    func convertCurrent(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "A": 1.0,
            "kA": 1000.0,
            "mA": 0.001,
            "Bi": 10.0,
            "abA": 10.0,
            "emuI": 10.0,
            "statA": 3.335641e-10,
            "esuI": 3.335641e-10,
            "CGSem": 10.0,
            "CGSes": 3.335641e-10
        ]
        
        guard let fromFactor = conversionFactors[fromUnit],
              let toFactor = conversionFactors[toUnit] else {
            return nil
        }
        
        let valueInAmperes = value * fromFactor
        let convertedValue = valueInAmperes / toFactor
        return convertedValue
    }


    func updateOutputValue(inputDouble: Double) {
        if let result = convertCurrent(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }


}

