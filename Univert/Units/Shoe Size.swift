//
//  Shoe Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Skostorlek: View {
    @State private var selectedFromUnit: String? = "EU"
    @State private var selectedToUnit: String? = "EU"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["EU", "UK", "US M", "US W", "cm", "in"]
    
    var body: some View {
        VStack {
            // Din befintliga UI-kod här (första HStack med "Från" och "Till")
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
            
            // Picker HStack
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
            
            // Enhetsetiketter
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
            
            // Input/output HStack
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
                        convertShoeSize()
                    }
                    .onChange(of: selectedFromUnit) { _ in
                        convertShoeSize()
                    }
                    .onChange(of: selectedToUnit) { _ in
                        convertShoeSize()
                    }

                Text(outputValue)
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
        .navigationTitle("Skostorlekar")
        .padding()
    }
    
    func convertShoeSize() {
        guard !inputValue.isEmpty,
              let inputDouble = Double(inputValue.replacingOccurrences(of: ",", with: ".")) else {
            outputValue = ""
            return
        }
        
        // Konvertera först till centimeter som referens
        let cmSize: Double
        
        // Konvertera från vald enhet till centimeter
        switch selectedFromUnit {
        case "EU":
            cmSize = (inputDouble + 10) / 1.5
        case "UK":
            let euSize = inputDouble + 33
            cmSize = (euSize + 10) / 1.5
        case "US M":
            let euSize = inputDouble + 33.5
            cmSize = (euSize + 10) / 1.5
        case "US W":
            let euSize = inputDouble + 31.5
            cmSize = (euSize + 10) / 1.5
        case "cm":
            cmSize = inputDouble
        case "in":
            cmSize = inputDouble * 2.54
        default:
            cmSize = inputDouble
        }
        
        // Konvertera från centimeter till mål-enhet
        var result: Double
        switch selectedToUnit {
        case "EU":
            result = cmSize * 1.5 - 10
        case "UK":
            let euSize = cmSize * 1.5 - 10
            result = euSize - 33
        case "US M":
            let euSize = cmSize * 1.5 - 10
            result = euSize - 33.5
        case "US W":
            let euSize = cmSize * 1.5 - 10
            result = euSize - 31.5
        case "cm":
            result = cmSize
        case "in":
            result = cmSize / 2.54
        default:
            result = cmSize
        }
        
        // Formatera resultatet
        if selectedToUnit == "cm" || selectedToUnit == "in" {
            outputValue = String(format: "%.1f", result).replacingOccurrences(of: ".", with: ",")
        } else {
            // Avrunda till närmaste halva storlek för skostorlekar
            let rounded = (result * 2).rounded() / 2
            if rounded == rounded.rounded() {
                outputValue = String(format: "%.0f", rounded)
            } else {
                outputValue = String(format: "%.1f", rounded).replacingOccurrences(of: ".", with: ",")
            }
        }
    }
}
