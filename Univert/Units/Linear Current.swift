//
//  Linear Current.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI

struct LinearCurrent: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "linear_current",
            titleKey: "unit_linear_current",
            units: ["A/m", "kA/m", "mA/m", "µA/m", "nA/m"],
            fullNames: [
                "A/m": "ampere per meter",
                "kA/m": "kiloampere per meter",
                "mA/m": "milliampere per meter",
                "µA/m": "microampere per meter",
                "nA/m": "nanoampere per meter"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "nA/m": 1e-9,
                    "µA/m": 1e-6,
                    "mA/m": 1e-3,
                    "A/m": 1.0,
                    "kA/m": 1e3
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
