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
                Text("(\(selectedFromUnit ?? ""))")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("(\(selectedToUnit ?? ""))")
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
                        if let inputDouble = Double(inputValue) {
                            updateOutputValue(inputDouble: inputDouble)
                        }
                    }
                    .onChange(of: selectedToUnit) { _ in
                        if let inputDouble = Double(inputValue) {
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
        // First convert everything to Pascals (Pa) - the SI unit for pressure
        let valueInPascals: Double
        
        switch fromUnit {
        case "bar":
            valueInPascals = value * 100_000
        case "psi":
            valueInPascals = value * 6894.76
        case "kPa":
            valueInPascals = value * 1_000
        case "atm":
            valueInPascals = value * 101_325
        case "mbar":
            valueInPascals = value * 100
        case "MPa":
            valueInPascals = value * 1_000_000
        case "Pa":
            valueInPascals = value
        default:
            return nil
        }
        
        // Then convert from Pascals to the target unit
        switch toUnit {
        case "bar":
            return valueInPascals / 100_000
        case "psi":
            return valueInPascals / 6894.76
        case "kPa":
            return valueInPascals / 1_000
        case "atm":
            return valueInPascals / 101_325
        case "mbar":
            return valueInPascals / 100
        case "MPa":
            return valueInPascals / 1_000_000
        case "Pa":
            return valueInPascals
        default:
            return nil
        }
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertPressure(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            let formattedResult = String(format: "%.2f", result).replacingOccurrences(of: ".", with: ",")
            outputValue = formattedResult
        } else {
            outputValue = "Ogiltig enhet"
        }
    }
}
