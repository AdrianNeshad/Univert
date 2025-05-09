//
//  Length.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//
import SwiftUI

struct Längd: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @State private var selectedFromUnit: String? = "m"
    @State private var selectedToUnit: String? = "m"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["m", "cm", "km", "dm", "mm", "mi", "in", "ft", "yd", "µm", "nm"]
    
    let fullNames: [String: String] = [
        "m": "Meter",
        "cm": "Centimeter",
        "km": "Kilometer",
        "dm": "Decimeter",
        "mm": "Millimeter",
        "mi": "Mile",
        "in": "Inch",
        "ft": "Foot",
        "yd": "Yard",
        "µm": "Micrometer",
        "nm": "Nanometer"
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
        .navigationTitle("Längd")
        .padding()
    }
    
    func convertLength(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "m": 1, // basenhet
            "cm": 0.01, // centimeter till meter
            "km": 1000, // kilometer till meter
            "dm": 0.1, // decimeter till meter
            "mm": 0.001, // millimeter till meter
            "mi": 1609.34, // miles till meter
            "in": 0.0254, // inch till meter
            "ft": 0.3048, // fot till meter
            "yd": 0.9144, // yard till meter
            "µm": 0.000001, // mikrometer till meter
            "nm": 0.000000001 // nanometer till meter
        ]
        
        // Kontrollera att enheterna finns i conversionFactors
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
            return nil // Om någon enhet inte finns i listan, returnera nil
        }

        // Omvandla till meter (basenhet)
        let valueInMeters = value * fromFactor
        
        // Omvandla från meter till mål-enhet
        let convertedValue = valueInMeters / toFactor
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertLength(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 4)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }


}
