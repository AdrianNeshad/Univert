//
//  Volume.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Volym: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "volume",
            titleKey: "unit_volume",
            units: ["L", "ml", "cl", "dl", "gal", "cup", "pint", "qrt", "fl oz", "tsp", "tbsp", "cm³", "dm³", "m³", "mm³"],
            fullNames: [
                "L": "Liter",
                "ml": "Milliliter",
                "cl": "Centiliter",
                "dl": "Deciliter",
                "gal": "Gallon",
                "cup": "Cup",
                "pint": "UK Pint",
                "qrt": "Quart",
                "fl oz": "Fluid Ounce",
                "cm³": "Cubic Centimeter",
                "dm³": "Cubic Decimeter",
                "m³": "Cubic Meter",
                "mm³": "Cubic Millimeter",
                "tsp": "Teaspoon",
                "tbsp": "Tablespoon",
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "L": 1,
                    "ml": 0.001,
                    "cl": 0.01,
                    "dl": 0.1,
                    "gal": 3.78541,
                    "cup": 0.236588,
                    "pint": 0.56826125,
                    "qrt": 0.946353,
                    "fl oz": 0.0295735,
                    "cm³": 0.001,
                    "dm³": 1,
                    "m³": 1000,
                    "mm³": 0.000001,
                    "tsp": 0.00492892,
                    "tbsp": 0.0147868,
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
