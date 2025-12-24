//
//  Length.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Längd: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "length",
            titleKey: "unit_length",
            units: ["m", "cm", "in", "ft", "km", "dm", "mm", "mi", "yd", "µm", "nm"],
            fullNames: [
                "m": "Meter",
                "cm": "Centimeter",
                "km": "Kilometer",
                "dm": "Decimeter",
                "mm": "Millimeter",
                "mi": "Mile",
                "in": "Inch",
                "ft": "Foot",
                "yd": "Yard",
                "µm": "Micrometer",
                "nm": "Nanometer"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "m": 1,
                    "cm": 0.01,
                    "km": 1000,
                    "dm": 0.1,
                    "mm": 0.001,
                    "mi": 1609.34,
                    "in": 0.0254,
                    "ft": 0.3048,
                    "yd": 0.9144,
                    "µm": 0.000001,
                    "nm": 0.000000001
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
