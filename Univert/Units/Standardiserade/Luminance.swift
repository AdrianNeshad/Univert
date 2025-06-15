//
//  Luminance.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI

struct Luminance: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "luminance",
            titleKey: "unit_luminance",
            units: [
                "cd/m²", "cd/cm²", "cd/ft²", "cd/in²", "sb", "nt", "asb", "fL", "lambert", "μsb"
            ],
            fullNames: [
                "cd/m²": "Candela/square meter",
                "cd/cm²": "Candela/square centimeter",
                "cd/ft²": "Candela/square foot",
                "cd/in²": "Candela/square inch",
                "sb": "Stilb",
                "nt": "Nit",
                "asb": "Apostilb",
                "fL": "Foot-lambert",
                "lambert": "Lambert",
                "μsb": "Microstilb"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "cd/m²": 1.0,
                    "cd/cm²": 10000.0,
                    "cd/ft²": 10.7639,
                    "cd/in²": 1550.003,
                    "sb": 10000.0,
                    "nt": 1.0,
                    "asb": 0.3183,
                    "fL": 3.426259,
                    "lambert": 3183.09886,
                    "μsb": 0.01
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 3
        ))
    }
}
