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

    var body: some View {
        Form {
            Toggle("Mörkt läge", isOn: $isDarkMode)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            Toggle("Använd svensk decimal (,)", isOn: $useSwedishDecimal)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
            Section {
                EmptyView()
            } footer: {
                VStack(spacing: 4) {
                    Text("© 2025 Univert App")
                    Text("Github.com/AdrianNeshad")
                    Text("Linkedin.com/in/adrian-neshad")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, -100)
            }
        }
        .navigationTitle("Inställningar")
    }
}
