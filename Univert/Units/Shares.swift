//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI
import AlertToast

struct Andelar: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @State private var selectedFromUnit: String? = "%"
    @State private var selectedToUnit: String? = "%"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    let unitId = "shares"

    let units = ["%", "‰", "mg/Kg", "mg/g", "g/Kg", "ug/Kg", "ug/g", "ppm", "ppb", "ppt", "pptr", "ppth", "ppq", "pg/g", "ng/g", "ng/Kg"]
        
        let fullNames: [String: String] = [
            "%": "Percent",
            "‰": "Per Mille",
            "mg/Kg": "Milligram per Kilogram",
            "mg/g": "Milligram per Gram",
            "g/Kg": "Gram per Kilogram",
            "ug/Kg": "Microgram per Kilogram",
            "ug/g": "Microgram per Gram",
            "ppm": "Parts Per Million",
            "ppb": "Parts Per Billion",
            "ppt": "Parts Per Trillion",
            "pptr": "Parts Per Trillion (pptr)",
            "ppth": "Parts Per Thousand (ppth)",
            "ppq": "Parts Per Quadrillion (ppq)",
            "pg/g": "Picogram per Gram",
            "ng/g": "Nanogram per Gram",
            "ng/Kg": "Nanogram per Kilogram"
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
        .navigationTitle(appLanguage == "sv" ? "Andelar" : "Shares")
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

    func convertShares(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "%": 1.0,
            "‰": 0.1,
            "mg/Kg": 0.0001,
            "mg/g": 0.1,
            "g/Kg": 0.1,
            "ug/Kg": 1e-7,
            "ug/g": 0.0001,
            "ppm": 0.0001,
            "ppb": 1e-7,
            "ppt": 1e-10,
            "pptr": 1e-10,
            "ppth": 0.1,
            "ppq": 1e-13,
            "pg/g": 1e-10,
            "ng/g": 0.0001,
            "ng/Kg": 1e-7
        ]
        
        guard let fromFactor = conversionFactors[fromUnit],
              let toFactor = conversionFactors[toUnit] else {
            return nil
        }
        let valueInPercent = value * fromFactor
        let convertedValue = valueInPercent / toFactor
        return convertedValue
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertShares(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 4)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }
}
