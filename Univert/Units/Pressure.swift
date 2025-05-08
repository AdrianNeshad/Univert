//
//  Pressure.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Tryck: View {
    @State private var selectedFromUnit: String? = "bar"
    @State private var selectedToUnit: String? = "bar"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["bar", "psi", "kPa", "atm", "mbar", "MPa", "Pa"]
    
    let fullNames: [String: String] = [
        "bar": "Bar",
        "psi": "Psi",
        "kPa": "Kilopascal",
        "atm": "Atmosphere",
        "mbar": "Millibar",
        "MPa": "Megapascal",
        "Pa": "Pascal"
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
            }
            
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
            }
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
                        let formattedValue = newValue.replacingOccurrences(of: ",", with: ".")
                        if let inputDouble = Double(formattedValue) {
                            updateOutputValue(inputDouble: inputDouble)
                        } else {
                            outputValue = ""
                        }
                    }
                    .onChange(of: selectedFromUnit) { _ in
                        let formattedValue = inputValue.replacingOccurrences(of: ",", with: ".")
                        if let inputDouble = Double(formattedValue) {
                            updateOutputValue(inputDouble: inputDouble)
                        }
                    }
                    .onChange(of: selectedToUnit) { _ in
                        let formattedValue = inputValue.replacingOccurrences(of: ",", with: ".")
                        if let inputDouble = Double(formattedValue) {
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
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        Spacer()
        .navigationTitle("Tryck")
        .padding()
    }
    
    func convertPressure(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "bar": 100000,
            "psi": 6894.76,
            "kPa": 1000,
            "atm": 101325,
            "mbar": 100,
            "MPa": 1000000,
            "Pa": 1
        ]
        
        // Kontrollera om enheterna finns i conversionFactors
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
            return nil // Om någon enhet inte finns i listan, returnera nil
        }
        
        // Omvandla till Pascal (Pa) som basenhet
        let valueInPascals = value * fromFactor
        
        // Omvandla från Pascal (Pa) till mål-enheten
        let convertedValue = valueInPascals / toFactor
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertPressure(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }

}
