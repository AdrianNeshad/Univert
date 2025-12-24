//
//  Magnetic Field.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-14.
//

import SwiftUI

struct MagnetiskFältstyrka: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "magnetic_field_strength",
            titleKey: "unit_magnetic_field_strength",
            units: ["A/m", "At/m", "kA/m", "Oe"],
            fullNames: [
                "A/m": "Ampere/meter",
                "At/m": "Ampere-turn/meter",
                "kA/m": "Kiloampere/meter",
                "Oe": "Oersted"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "A/m": 1.0,
                    "At/m": 1.0,
                    "kA/m": 1000.0,
                    "Oe": 79.57747
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else { return nil }
                return value * fromFactor / toFactor
            },
            maxFractionDigits: 2
        ))
    }
}
