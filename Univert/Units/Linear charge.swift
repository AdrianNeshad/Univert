//
//  Linear charge.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Linear_charge: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "linear_charge",
            titleKey: "unit_linear_charge",
            units: ["C/m", "mC/m", "µC/m", "nC/m", "pC/m", "fC/m", "aC/m"],
            fullNames: [
                "C/m": "coulombs/meter",
                "mC/m": "millicoulombs/meter",
                "µC/m": "microcoulombs/meter",
                "nC/m": "nanocoulombs/meter",
                "pC/m": "picocoulombs/meter",
                "fC/m": "femtocoulombs/meter",
                "aC/m": "attocoulombs/meter"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "C/m": 1.0,
                    "mC/m": 1e-3,
                    "µC/m": 1e-6,
                    "nC/m": 1e-9,
                    "pC/m": 1e-12,
                    "fC/m": 1e-15,
                    "aC/m": 1e-18
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
