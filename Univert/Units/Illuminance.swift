//
//  Illumination.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-08.
//

import SwiftUI

struct Illuminance: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "illuminance",
            titleKey: "unit_illuminance",
            units: [
                "lx", "ph", "fc", "lm/ft²", "lm/cm²", "lm/m²"
            ],
            fullNames: [
                "lx": "Lux",
                "ph": "Phot",
                "fc": "Foot-candle",
                "lm/ft²": "Lumen per square foot",
                "lm/cm²": "Lumen per square centimeter",
                "lm/m²": "Lumen per square meter"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "lx": 1.0,
                    "ph": 10000.0,
                    "fc": 10.76391,
                    "lm/ft²": 10.76391,
                    "lm/cm²": 10000.0,
                    "lm/m²": 1.0
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
