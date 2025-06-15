//
//  Shoe Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI
import AlertToast

struct ShoeSizeRow {
    let eu: Double
    let uk: Double
    let usM: Double
    let usW: Double
    let cm: Double
}

struct Skostorlek: View {
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFromUnit: String? = "EU"
    @State private var selectedToUnit: String? = "EU"
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)

    let unitId = "shoe_size"
    
    let units = ["EU", "UK", "US M", "US W", "cm", "in"]
    
    let fullNames: [String: String] = [
        "EU": "Europe",
        "UK": "United Kingdom",
        "US M": "US Men's",
        "US W": "US Women's",
        "cm": "Centimeter",
        "in": "Inch"
    ]
    
    let shoeSizeTable: [ShoeSizeRow] = [
        ShoeSizeRow(eu: 35, uk: 2.5, usM: 3, usW: 4, cm: 22),
        ShoeSizeRow(eu: 36, uk: 3.5, usM: 4, usW: 5, cm: 22.5),
        ShoeSizeRow(eu: 37, uk: 4, usM: 4.5, usW: 5.5, cm: 23),
        ShoeSizeRow(eu: 37.5, uk: 4.5, usM: 5, usW: 6, cm: 23.5),
        ShoeSizeRow(eu: 38, uk: 5, usM: 5.5, usW: 6.5, cm: 24),
        ShoeSizeRow(eu: 38.5, uk: 5.5, usM: 6, usW: 7, cm: 24.5),
        ShoeSizeRow(eu: 39, uk: 6, usM: 6.5, usW: 7.5, cm: 25),
        ShoeSizeRow(eu: 40, uk: 6.5, usM: 7, usW: 8, cm: 25.5),
        ShoeSizeRow(eu: 40.5, uk: 7, usM: 7.5, usW: 8.5, cm: 26),
        ShoeSizeRow(eu: 41, uk: 7, usM: 8, usW: 9, cm: 26),
        ShoeSizeRow(eu: 42, uk: 8, usM: 9, usW: 10, cm: 27),
        ShoeSizeRow(eu: 42.5, uk: 8.5, usM: 9.5, usW: 10.5, cm: 27.5),
        ShoeSizeRow(eu: 43, uk: 9, usM: 10, usW: 11, cm: 28),
        ShoeSizeRow(eu: 44, uk: 9.5, usM: 10.5, usW: 11.5, cm: 28.5),
        ShoeSizeRow(eu: 44.5, uk: 10, usM: 11, usW: 12, cm: 29),
        ShoeSizeRow(eu: 45, uk: 10.5, usM: 11.5, usW: 12.5, cm: 29.5),
        ShoeSizeRow(eu: 46, uk: 11, usM: 12, usW: 13, cm: 30),
        ShoeSizeRow(eu: 46.5, uk: 11.5, usM: 12.5, usW: 13.5, cm: 30.5),
        ShoeSizeRow(eu: 47, uk: 12, usM: 13, usW: 14, cm: 31),
        ShoeSizeRow(eu: 48, uk: 13, usM: 14, usW: 15, cm: 32),
        ShoeSizeRow(eu: 49, uk: 14, usM: 15, usW: 16, cm: 33),
        ShoeSizeRow(eu: 50, uk: 15, usM: 16, usW: 17, cm: 34)
    ]

    var body: some View {
        VStack {
            HStack {
                        Menu {
                            ForEach(units, id: \.self) { unit in
                                Button {
                                    selectedFromUnit = unit
                                    convertUsingTable()
                                    feedbackGenerator.impactOccurred()
                                    feedbackGenerator.prepare()
                                } label: {
                                    Text("\(unit) - \(fullNames[unit] ?? "")")
                                }
                            }
                        } label: {
                            Text(StringManager.shared.get("from"))
                                .foregroundColor(.primary)
                                .font(.title)
                                .bold()
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                                .multilineTextAlignment(.center)
                        }
                Spacer()
                    
                Button(action: swapUnits) {
                    Image("univert.svg")
                        .resizable()
                        .frame(width: 50, height: 40)
                }
                
                Spacer()
                        Menu {
                            ForEach(units, id: \.self) { unit in
                                Button {
                                    selectedToUnit = unit
                                    convertUsingTable()
                                    feedbackGenerator.impactOccurred()
                                    feedbackGenerator.prepare()
                                } label: {
                                    Text("\(unit) - \(fullNames[unit] ?? "")")
                                }
                            }
                        } label: {
                            Text(StringManager.shared.get("to"))
                                .foregroundColor(.primary)
                                .font(.title)
                                .bold()
                                .padding(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                                .multilineTextAlignment(.center)
                        }
                    }
            .padding(.horizontal, 50)
            .frame(maxWidth: .infinity)
            
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
                    .background(colorScheme == .dark ? Color.gray.opacity(0.35) : Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
                    .onChange(of: inputValue) { newValue in
                        if !useSwedishDecimal {
                            let replaced = newValue.replacingOccurrences(of: ",", with: ".")
                            if replaced != newValue {
                                inputValue = replaced
                            }
                        }
                        convertUsingTable()
                    }
                    .onChange(of: selectedFromUnit) { _ in
                        convertUsingTable()
                    }
                    .onChange(of: selectedToUnit) { _ in
                        convertUsingTable()
                    }


                Text(outputValue)
                    .padding(10)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color.gray.opacity(0.35) : Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
            }
            .padding([.leading, .trailing], 10)
        }
        .padding(.top, 20)
        Spacer()
        .navigationTitle(StringManager.shared.get("unit_shoe_size"))
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
            feedbackGenerator.prepare()
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
    
    func convertUsingTable() {
        guard let fromUnit = selectedFromUnit,
              let toUnit = selectedToUnit,
              let inputDouble = Double(inputValue.replacingOccurrences(of: ",", with: ".")) else {
            outputValue = ""
            return
        }
        
        let nearestRow = shoeSizeTable.min(by: { abs(value(for: fromUnit, in: $0) - inputDouble) < abs(value(for: fromUnit, in: $1) - inputDouble) })
        
        guard let row = nearestRow else {
            outputValue = "Error"
            return
        }
        let output = value(for: toUnit, in: row)
        outputValue = FormatterHelper.shared.formatResult(output, useSwedishDecimal: useSwedishDecimal, maximumFractionDigits: 1)
    }
    
    func value(for unit: String, in row: ShoeSizeRow) -> Double {
        switch unit {
        case "EU": return row.eu
        case "UK": return row.uk
        case "US M": return row.usM
        case "US W": return row.usW
        case "cm": return row.cm
        case "in": return row.cm / 2.54
        default: return 0
        }
    }
    
    private func swapUnits() {
        let tempUnit = selectedFromUnit
        selectedFromUnit = selectedToUnit
        selectedToUnit = tempUnit
        convertUsingTable()
        feedbackGenerator.impactOccurred()
        feedbackGenerator.prepare()
    }
}
