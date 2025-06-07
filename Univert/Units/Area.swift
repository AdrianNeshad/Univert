//
//  Area.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-07.
//

import SwiftUI

struct Yta: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "area",
            titleKey: "unit_area",
            units: ["m²", "km²", "cm²", "mm²", "ha", "ac", "mi²", "yd²", "ft²", "in²"],
            fullNames: [
                "m²": "Square Meter",
                "km²": "Square Kilometer",
                "cm²": "Square Centimeter",
                "mm²": "Square Millimeter",
                "ha": "Hectare",
                "ac": "Acre",
                "mi²": "Square Mile",
                "yd²": "Square Yard",
                "ft²": "Square Foot",
                "in²": "Square Inch"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "m²": 1,
                    "km²": 1e6,
                    "cm²": 1e-4,
                    "mm²": 1e-6,
                    "ha": 1e4,
                    "ac": 4046.856,
                    "mi²": 2.58999e6,
                    "yd²": 0.836127,
                    "ft²": 0.092903,
                    "in²": 0.00064516
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
