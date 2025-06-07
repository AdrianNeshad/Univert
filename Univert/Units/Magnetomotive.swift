//
//  Magnetomotive.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-14.
//

import SwiftUI

struct Magnetomotorisk: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "magnetomotive_force",
            titleKey: "unit_magnetomotive_force",
            units: ["At", "kAt", "mAt", "abAt", "Gb"],
            fullNames: [
                "At": "Ampere-turn",
                "kAt": "Kiloampere-turn",
                "mAt": "Milliampere-turn",
                "abAt": "Abampere-turn",
                "Gb": "Gilbert"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "At": 1.0,
                    "kAt": 1000.0,
                    "mAt": 0.001,
                    "abAt": 10.0,
                    "Gb": 0.7957747154595
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else { return nil }
                return value * fromFactor / toFactor
            },
            maxFractionDigits: 4
        ))
    }
}
