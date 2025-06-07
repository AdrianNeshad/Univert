//
//  Mass.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Vikt: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "weight",
            titleKey: "unit_weight",
            units: ["kg", "lbs", "mg", "g", "hg", "μg", "mcg", "ng", "m ton", "N", "kN", "carat", "t oz", "t lb", "stone", "oz"],
            fullNames: [
                "mg": "Milligram",
                "g": "Gram",
                "hg": "Hektogram",
                "kg": "Kilogram",
                "lbs": "Pounds",
                "μg": "Microgram",
                "mcg": "Microgram (mcg)",
                "ng": "Nanogram",
                "m ton": "Metric Ton",
                "N": "Newton",
                "kN": "Kilonewton",
                "carat": "Carat",
                "t oz": "Troy Ounce",
                "t lb": "Troy Pound",
                "stone": "Stone",
                "oz": "Ounce"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "mg": 0.001,
                    "g": 1,
                    "hg": 100,
                    "kg": 1000,
                    "m ton": 1000000,
                    "carat": 0.2,
                    "t oz": 31.1035,
                    "t lb": 373.2417,
                    "stone": 6350,
                    "oz": 28.3495,
                    "lbs": 453.59237,
                    "N": 9.81,
                    "kN": 9810,
                    "μg": 0.000001,
                    "mcg": 0.000001,
                    "ng": 0.000000001
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                let valueInGrams = value * fromF
                return valueInGrams / toF
            },
            maxFractionDigits: 2
        ))
    }
}
