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
        }
        .navigationTitle("Inställningar")
    }
}
