//
//  Volume charge.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI
import AlertToast

struct Volume_charge: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @State private var selectedFromUnit: String? = "C/m³"
    @State private var selectedToUnit: String? = "C/m³"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    let unitId = "volume_charge"
    
    let units = ["C/m³", "mC/m³", "µC/m³", "nC/m³", "pC/m³", "fC/m³", "aC/m³"]
    
    let fullNames: [String: String] = [
        "C/m³": "coulombs/m³",
        "mC/m³": "millicoulombs/m³",
        "µC/m³": "microcoulombs/m³",
        "nC/m³": "nanocoulombs/m³",
        "pC/m³": "picocoulombs/m³",
        "fC/m³": "femtocoulombs/m³",
        "aC/m³": "attocoulombs/m³"
    ]

    var body: some View {
        VStack {
            HStack {
                Text(StringManager.shared.get("from"))
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

                Text(StringManager.shared.get("to"))
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
            }
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
                TextField(StringManager.shared.get("value"), text: $inputValue)
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
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        Spacer()
        .navigationTitle(StringManager.shared.get("unit_volume_charge"))
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
                toastMessage = StringManager.shared.get("addedtofavorites")
                toastIcon = "star.fill"
                toastColor = .yellow
            } else {
                toastMessage = StringManager.shared.get("removed")
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
    
    func convertVolumeChargeDensity(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let conversionFactors: [String: Double] = [
            "C/m³": 1.0,
            "mC/m³": 1e-3,
            "µC/m³": 1e-6,
            "nC/m³": 1e-9,
            "pC/m³": 1e-12,
            "fC/m³": 1e-15,
            "aC/m³": 1e-18
        ]
        
        guard let fromFactor = conversionFactors[fromUnit],
              let toFactor = conversionFactors[toUnit] else {
            return nil
        }

        let valueInBase = value * fromFactor
        return valueInBase / toFactor
    }

    func updateOutputValue(inputDouble: Double) {
        if let result = convertVolumeChargeDensity(value: inputDouble, fromUnit: selectedFromUnit ?? "", toUnit: selectedToUnit ?? "") {
            outputValue = FormatterHelper.shared.formatResult(result, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 2)
        } else {
            outputValue = "Error"
        }
    }
}
