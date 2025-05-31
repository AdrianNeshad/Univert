//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI
import AlertToast

struct ViskositetD: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @State private var selectedFromUnit: String? = "Pa s"
    @State private var selectedToUnit: String? = "Pa s"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    let unitId = "viscosity_dynamic"
    
    let units = ["Pa s", "kgf s/m²", "N s/m²", "mN s/m²", "dyne s/cm²", "P", "EP", "PP", "TP", "GP", "MP", "kP", "hP", "daP", "dP", "cP", "mP", "µP", "nP", "pP", "fP", "aP", "lbf s/in²", "lbf s/ft²", "pdl s/ft²", "g/cm/s", "slug/ft/s", "lb/ft/s", "lb/ft/h"]

    let fullNames: [String: String] = [
        "Pa s": "Pascal-second",
        "kgf s/m²": "Kilogram-force second per square meter",
        "N s/m²": "Newton second per square meter",
        "mN s/m²": "Millinewton second per square meter",
        "dyne s/cm²": "Dyne second per square centimeter",
        "P": "Poise",
        "EP": "Exapoise",
        "PP": "Petapoise",
        "TP": "Terapoise",
        "GP": "Gigapoise",
        "MP": "Megapoise",
        "kP": "Kilopoise",
        "hP": "Hectopoise",
        "daP": "Dekapoise",
        "dP": "Decipoise",
        "cP": "Centipoise",
        "mP": "Millipoise",
        "µP": "Micropoise",
        "nP": "Nanopoise",
        "pP": "Picopoise",
        "fP": "Femtopoise",
        "aP": "Attopoise",
        "lbf s/in²": "Pound-force second per square inch",
        "lbf s/ft²": "Pound-force second per square foot",
        "pdl s/ft²": "Poundal second per square foot",
        "g/cm/s": "Gram per centimeter per second",
        "slug/ft/s": "Slug per foot per second",
        "lb/ft/s": "Pound per foot per second",
        "lb/ft/h": "Pound per foot per hour"
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
                            Text("(\(selectedFromUnit ?? "")) \(fullNames[selectedFromUnit ?? ""] ?? "")")
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                            
                            Text("(\(selectedToUnit ?? "")) \(fullNames[selectedToUnit ?? ""] ?? "")")
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
                    .textSelection(.enabled)
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle(appLanguage == "sv" ? "Viskositet (dynamisk)" : "Viscosity (dynamic)")
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
                .toast(isPresenting: $showToast) {
                    AlertToast(displayMode: .hud, type: .systemImage(toastIcon, toastColor), title: toastMessage)
                }
    }
    func toggleFavorite() {
        if let index = currentUnits.firstIndex(where: { $0.id == unitId }) {
            currentUnits[index].isFavorite.toggle()
            isFavorite = currentUnits[index].isFavorite

            if let data = try? JSONEncoder().encode(currentUnits) {
                savedUnitsData = data
            }

            if isFavorite {
                toastMessage = appLanguage == "sv" ? "Tillagd i favoriter" : "Added to Favorites"
                toastIcon = "star.fill"
                toastColor = .yellow
            } else {
                toastMessage = appLanguage == "sv" ? "Borttagen" : "Removed"
                toastIcon = "star"
                toastColor = .gray
            }

            withAnimation {
                showToast = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    showToast = false
                }
            }
        }
    }

    func convertViscosityD(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
                "Pa s": 1.0,
                "kgf s/m²": 9.80665,
                "N s/m²": 1.0,
                "mN s/m²": 0.001,
                "dyne s/cm²": 0.1,
                "P": 0.1,
                "EP": 1.0E+17,
                "PP": 1.0E+14,
                "TP": 1.0E+11,
                "GP": 1.0E+8,
                "MP": 1.0E+5,
                "kP": 100,
                "hP": 10,
                "daP": 1,
                "dP": 0.01,
                "cP": 0.001,
                "mP": 0.0001,
                "µP": 1.0E-7,
                "nP": 1.0E-10,
                "pP": 1.0E-13,
                "fP": 1.0E-16,
                "aP": 1.0E-19,
                "lbf s/in²": 6894.7572931684,
                "lbf s/ft²": 47.8802589802,
                "pdl s/ft²": 1.4881639436,
                "g/cm/s": 0.1,
                "slug/ft/s": 47.8802589802,
                "lb/ft/s": 1.4881639436,
                "lb/ft/h": 0.0004133789
            ]
        
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
                return nil
            }
            let valueInBaseUnit = value * fromFactor
            let convertedValue = valueInBaseUnit / toFactor
            return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertViscosityD(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }
}
