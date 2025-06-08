//
//  UnitConverterView.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI
import AlertToast

struct UnitDefinition {
    let id: String
    let titleKey: String
    let units: [String]
    let fullNames: [String: String]
    let convert: (Double, String, String) -> Double?
    let maxFractionDigits: Int
}

struct UnitConverterView: View {
    let definition: UnitDefinition

    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @Environment(\.colorScheme) var colorScheme

    @State private var selectedFromUnit: String?
    @State private var selectedToUnit: String?
    @State private var inputValue = ""
    @State private var outputValue = ""
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastIcon = "star.fill"
    @State private var toastColor = Color.yellow
    @State private var isFavorite = false
    @State private var currentUnits: [Units] = []

    var body: some View {
        VStack {
            HStack {
                Text(StringManager.shared.get("from"))
                    .font(.title)
                    .bold()
                    .padding(10)
                    .background(colorScheme == .dark ? Color.gray.opacity(0.25) : Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("➤")
                    .font(.title)
                    .bold()
                    .frame(width: 40)

                Text(StringManager.shared.get("to"))
                    .font(.title)
                    .bold()
                    .padding(10)
                    .background(colorScheme == .dark ? Color.gray.opacity(0.25) : Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 50)
            .frame(maxWidth: .infinity)

            HStack {
                Text("►")
                    .font(.title)
                    .frame(width: 50)
                PomodoroPicker(selection: $selectedFromUnit, options: definition.units) { unit in
                    Text(unit)
                        .font(.title)
                        .bold()
                        .frame(width: 100)
                        .padding(.leading, -90)
                }
                PomodoroPicker(selection: $selectedToUnit, options: definition.units) { unit in
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
                Text("(\(selectedFromUnit ?? "")) \(definition.fullNames[selectedFromUnit ?? ""] ?? "")")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)

                Text("(\(selectedToUnit ?? "")) \(definition.fullNames[selectedToUnit ?? ""] ?? "")")
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
                    .onChange(of: inputValue, perform: handleInput)
                    .onChange(of: selectedFromUnit) { _ in triggerConversion() }
                    .onChange(of: selectedToUnit) { _ in triggerConversion() }

                Text(outputValue.isEmpty ? "" : outputValue)
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
        .navigationTitle(StringManager.shared.get(definition.titleKey))
        .padding()
        .onAppear {
            selectedFromUnit = definition.units.first
            selectedToUnit = definition.units.first
            loadFavorites()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .systemImage(toastIcon, toastColor), title: toastMessage)
        }
    }

    private func handleInput(_ newValue: String) {
        if !useSwedishDecimal {
            let replaced = newValue.replacingOccurrences(of: ",", with: ".")
            if replaced != newValue {
                inputValue = replaced
            }
        }
        triggerConversion()
    }

    private func triggerConversion() {
        let normalized = inputValue.replacingOccurrences(of: ",", with: ".")
        if let value = Double(normalized),
           let from = selectedFromUnit,
           let to = selectedToUnit,
           let result = definition.convert(value, from, to) {
            outputValue = FormatterHelper.shared.formatResult(
                result,
                useSwedishDecimal: useSwedishDecimal,
                maximumFractionDigits: definition.maxFractionDigits
            )
        } else {
            outputValue = ""
        }
    }

    private func loadFavorites() {
        if let data = savedUnitsData,
           let saved = try? JSONDecoder().decode([Units].self, from: data) {
            currentUnits = saved
        } else {
            currentUnits = Units.preview()
        }
        if let match = currentUnits.first(where: { $0.id == definition.id }) {
            isFavorite = match.isFavorite
        }
    }

    private func toggleFavorite() {
        if let index = currentUnits.firstIndex(where: { $0.id == definition.id }) {
            currentUnits[index].isFavorite.toggle()
            isFavorite = currentUnits[index].isFavorite

            if let data = try? JSONEncoder().encode(currentUnits) {
                savedUnitsData = data
            }

            toastMessage = StringManager.shared.get(isFavorite ? "addedtofavorites" : "removed")
            toastIcon = isFavorite ? "star.fill" : "star"
            toastColor = isFavorite ? .yellow : .gray

            withAnimation { showToast = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation { showToast = false }
            }
        }
    }
}
    
