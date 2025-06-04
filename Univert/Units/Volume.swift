//
//  Volume.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI
import AlertToast

struct Volym: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @State private var selectedFromUnit: String? = "L"
    @State private var selectedToUnit: String? = "L"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    let unitId = "volume"
    
    let units = ["L", "ml", "cl", "dl", "gal", "cup", "pint", "qrt", "fl oz", "cm³", "dm³", "m³", "mm³"]
    
    let fullNames: [String: String] = [
        "L": "Liter",
        "ml": "Milliliter",
        "cl": "Centiliter",
        "dl": "Deciliter",
        "gal": "Gallon",
        "cup": "Cup",
        "pint": "UK Pint",
        "qrt": "Quart",
        "fl oz": "Fluid Ounce",
        "cm³": "Cubic Centimeter",
        "dm³": "Cubic Decimeter",
        "m³": "Cubic Meter",
        "mm³": "Cubic Millimeter"
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
            } //HStacK
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
            .navigationTitle(appLanguage == "sv" ? "Volym" : "Volume")
            .padding()
            .onAppear {
                        if let data = savedUnitsData,
                           let savedUnits = try? JSONDecoder().decode([Units].self, from: data) {
                            currentUnits = savedUnits
                        } else {
                            currentUnits = Units.preview(for: appLanguage)
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

    func convertVolume(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "L": 1,
            "ml": 0.001,
            "cl": 0.01,
            "dl": 0.1,
            "gal": 0.264172,
            "cup": 0.236588,
            "pint": 0.56826125,
            "qrt": 1.05669,
            "fl oz": 33.814,
            "cm³": 0.001,
            "dm³": 1,
            "m³": 1000,
            "mm³": 0.000000001
        ]
        guard let fromFactor = conversionFactors[fromUnit], let toFactor = conversionFactors[toUnit] else {
            return nil
        }
        let valueInLiters = value * fromFactor
        let convertedValue = valueInLiters / toFactor
        return convertedValue
    }
    
    func updateOutputValue(inputDouble: Double) {
        if let result = convertVolume(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
        } else {
            outputValue = "Ogiltig enhet"
        }
    }
}
