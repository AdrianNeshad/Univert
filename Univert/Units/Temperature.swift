//
//  Temperature.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Temperatur: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "°C"
    @State private var selectedToUnit: String? = "°C"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["°C", "°F", "K"]
    
    let fullNames: [String: String] = [
            "°C": "Celsius",
            "°F": "Fahrenheit",
            "K": "Kelvin",
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
        .navigationTitle("Temperatur")
        .padding()
    }
    
    func convertTemperature(value: Double, fromUnit: String, toUnit: String) -> Double? {
        switch (fromUnit, toUnit) {
        case ("°C", "°F"):
            return (value * 9/5) + 32
        case ("°F", "°C"):
            return (value - 32) * 5/9
        case ("°C", "Kelvin"):
            return value + 273.15
        case ("Kelvin", "°C"):
            return value - 273.15
        case ("°F", "Kelvin"):
            return (value - 32) * 5/9 + 273.15
        case ("Kelvin", "°F"):
            return (value - 273.15) * 9/5 + 32
        default:
            return value
        }
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertTemperature(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }

}
