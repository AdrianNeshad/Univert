//
//  Data Transfer Speed.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Dataöverföringshastighet: View {
    @State private var selectedFromUnit: String? = "bit/s"
    @State private var selectedToUnit: String? = "bit/s"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["bit/s", "B/s", "Kbit/s", "KB/s", "Mbit/s", "MB/s", "Gbit/s", "GB/s", "Tbit/s", "TB/s"]
    
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
        .navigationTitle("Dataöverföringshastighet")
        .padding()
    }
    
    func convertDataTransferSpeed(value: Double, fromUnit: String, toUnit: String) -> Double? {
        // First convert everything to bits per second
        let valueInBitsPerSecond: Double
        
        switch fromUnit {
        case "bit/s":
            valueInBitsPerSecond = value
        case "B/s":
            valueInBitsPerSecond = value * 8
        case "Kbit/s":
            valueInBitsPerSecond = value * 1000
        case "KB/s":
            valueInBitsPerSecond = value * 8 * 1000
        case "Mbit/s":
            valueInBitsPerSecond = value * 1000 * 1000
        case "MB/s":
            valueInBitsPerSecond = value * 8 * 1000 * 1000
        case "Gbit/s":
            valueInBitsPerSecond = value * 1000 * 1000 * 1000
        case "GB/s":
            valueInBitsPerSecond = value * 8 * 1000 * 1000 * 1000
        case "Tbit/s":
            valueInBitsPerSecond = value * 1000 * 1000 * 1000 * 1000
        case "TB/s":
            valueInBitsPerSecond = value * 8 * 1000 * 1000 * 1000 * 1000
        default:
            return nil
        }
        
        // Then convert from bits per second to the target unit
        switch toUnit {
        case "bit/s":
            return valueInBitsPerSecond
        case "B/s":
            return valueInBitsPerSecond / 8
        case "Kbit/s":
            return valueInBitsPerSecond / 1000
        case "KB/s":
            return valueInBitsPerSecond / (8 * 1000)
        case "Mbit/s":
            return valueInBitsPerSecond / (1000 * 1000)
        case "MB/s":
            return valueInBitsPerSecond / (8 * 1000 * 1000)
        case "Gbit/s":
            return valueInBitsPerSecond / (1000 * 1000 * 1000)
        case "GB/s":
            return valueInBitsPerSecond / (8 * 1000 * 1000 * 1000)
        case "Tbit/s":
            return valueInBitsPerSecond / (1000 * 1000 * 1000 * 1000)
        case "TB/s":
            return valueInBitsPerSecond / (8 * 1000 * 1000 * 1000 * 1000)
        default:
            return nil
        }
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertDataTransferSpeed(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            let formattedResult = String(format: "%.2f", result).replacingOccurrences(of: ".", with: ",")
            outputValue = formattedResult
        } else {
            outputValue = "Ogiltig enhet"
        }
    }
}
