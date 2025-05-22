//
//  Base.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-14.
//

import SwiftUI

struct Talsystem: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "B. 10"
    @State private var selectedToUnit: String? = "B. 10"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @AppStorage("appLanguage") private var appLanguage = "en" 
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    
    let unitId = "numeral_system"
    
    let units = ["B. 10", "B. 2", "B. 3", "B. 6", "B. 8", "B. 16"]


    let fullNames: [String: String] = [
        "B. 2": "Base 2 - Binary",
        "B. 10": "Base 10 - Decimal",
        "B. 8": "Base 8 - Octal",
        "B. 16": "Base 16 - Hexadecimal",
        "B. 6": "Base 6 - Heximal",
        "B. 3": "Base 3 - Trinary"
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
        .navigationTitle(appLanguage == "sv" ? "Talsystem" : "Numeral System")
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

    func convertBase(value: String, fromUnit: String, toUnit: String) -> String {
        let bases: [String: Int] = [
            "B. 2": 2,
            "B. 8": 8,
            "B. 10": 10,
            "B. 16": 16,
            "B. 6": 6,
            "B. 3": 3
        ]
        
        guard let fromBase = bases[fromUnit],
              let toBase = bases[toUnit],
              let number = Int(value, radix: fromBase) else {
            return appLanguage == "sv" ? "Ogiltigt tal" : "Invalid input"
        }
        
        return String(number, radix: toBase).uppercased()
    }

    func updateOutputValue(inputDouble: Double) {
        outputValue = convertBase(value: inputValue, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "")
    }

}
