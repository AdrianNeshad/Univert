//
//  Untitled.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-08.
//

import SwiftUI

struct LuminousIntensity: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "luminous_intensity",
            titleKey: "unit_luminous_intensity",
            units: [
                "cd", "mcd", "kcd", "Mcd", "scd", "hef", "sb-cm²", "HK", "cp"
            ],
            fullNames: [
                "cd": "Candela",
                "mcd": "Millicandela",
                "kcd": "Kilocandela",
                "Mcd": "Megacandela",
                "scd": "Standard candela",
                "hef": "Hefnerkerze",
                "sb-cm²": "Stilb-centimeter squared",
                "HK": "Hefnerkerze (alt)",
                "cp": "Candlepower"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "cd": 1.0,
                    "mcd": 1e-3,
                    "kcd": 1e3,
                    "Mcd": 1e6,
                    "scd": 1.0,
                    "hef": 0.903,
                    "sb-cm²": 100.0,
                    "HK": 0.903,
                    "cp": 0.981
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
