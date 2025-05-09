//
//  Data Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Datastorlek: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "b"
    @State private var selectedToUnit: String? = "b"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["b", "B", "KB", "MB", "GB", "TB", "PB", "EB"]
    
    let fullNames: [String: String] = [
        "b": "Bit",
        "B": "Byte",
        "KB": "Kilobyte",
        "MB": "Megabyte",
        "GB": "Gigabyte",
        "TB": "Terabyte",
        "PB": "Petabyte",
        "EB": "Exabyte"
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
                        // Omvandla komma till punkt och försök att konvertera till Double
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
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle("Datastorlek")
        .padding()
    }
    
    func convertDataSize(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "bit": 1,
            "byte": 8, // 1 byte = 8 bits
            "KB": 8 * 1024,
            "MB": 8 * 1024 * 1024, // 1 MB = 1024 KB
            "GB": 8 * 1024 * 1024 * 1024, // 1 GB = 1024 MB
            "TB": 8 * 1024 * 1024 * 1024 * 1024, // 1 TB = 1024 GB
            "PB": 8 * 1024 * 1024 * 1024 * 1024 * 1024, // 1 PB = 1024 TB
            "EB": 8 * 1024 * 1024 * 1024 * 1024 * 1024 * 1024 // 1 EB = 1024 PB
        ]
        
        // Kontrollera om enheterna finns i conversionFactors
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
            return nil // Om någon enhet inte finns i listan, returnera nil
        }

        // Omvandla till bit (basenhet)
        let valueInBits = value * fromFactor
        
        // Omvandla från bit till mål-enhet
        let convertedValue = valueInBits / toFactor
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertDataSize(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }

}
