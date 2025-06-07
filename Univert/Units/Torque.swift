//
//  Torque.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Vridmoment: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "torque",
            titleKey: "unit_torque",
            units: ["N m", "lb ft", "lb in", "kg m"],
            fullNames: [
                "N m": "Newton meter",
                "lb ft": "Pound foot",
                "lb in": "Pound inch",
                "kg m": "Kilogram meter"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "N m": 1.0,
                    "lb ft": 1.35582,
                    "lb in": 0.113,
                    "kg m": 9.80665
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
