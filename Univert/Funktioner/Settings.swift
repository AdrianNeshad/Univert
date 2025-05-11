//
//  Settings.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-09.
//

import SwiftUI

struct Inställningar: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("appLanguage") private var appLanguage = "sv" // default: svenska

    var body: some View {
        Form {
            Toggle(appLanguage == "sv" ? "Mörkt läge" : "Dark mode", isOn: $isDarkMode)
                .toggleStyle(SwitchToggleStyle(tint: .blue))

            Picker("Språk / Language", selection: $appLanguage) {
                Text("Svenska").tag("sv")
                Text("English").tag("en")
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: appLanguage) { newLang in
                if newLang == "sv" {
                    useSwedishDecimal = true
                } else {
                    useSwedishDecimal = false
                }
            }

            Toggle(appLanguage == "sv" ? "Svensk decimalseparator" : "Swedish decimal separator", isOn: $useSwedishDecimal)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .disabled(true) // gör den readonly – styrs nu av språket

            Section {
                EmptyView()
            } footer: {
                VStack(spacing: 4) {
                    Text("© 2025 Univert App")
                    Text("Github.com/AdrianNeshad")
                    Text("Linkedin.com/in/adrian-neshad")
                    Text(appVersion)
                }
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, -100)
            }
        }
        .navigationTitle(appLanguage == "sv" ? "Inställningar" : "Settings")

    }
    
    private var appVersion: String {
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
            let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
            return "Version \(version) (\(build))"
        }
}
