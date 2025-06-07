//
//  Radiation Absorbed.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Radiation_Absorbed: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "radiation_absorbed",
            titleKey: "unit_radiation_absorbed",
            units: ["Gy", "mGy", "µGy", "nGy", "rad", "mrad", "µrad"],
            fullNames: [
                "Gy": "gray",
                "mGy": "milligray",
                "µGy": "microgray",
                "nGy": "nanogray",
                "rad": "rad",
                "mrad": "millirad",
                "µrad": "microrad"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "Gy": 1.0,
                    "mGy": 1e-3,
                    "µGy": 1e-6,
                    "nGy": 1e-9,
                    "rad": 0.01,
                    "mrad": 1e-5,
                    "µrad": 1e-8
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
