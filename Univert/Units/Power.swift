//
//  Power.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Effekt: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "power",
            titleKey: "unit_power",
            units: ["W", "MW", "kW", "hp", "BTU/h", "ton/ref"],
            fullNames: [
                "W": "Watt",
                "MW": "Megawatt",
                "kW": "Kilowatt",
                "hp": "Horsepower",
                "BTU/h": "British Thermal Unit/hour",
                "ton/ref": "Ton of Refrigeration"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "W": 1,
                    "kW": 1000,
                    "MW": 1000000,
                    "hp": 745.7,
                    "BTU/h": 0.2931,
                    "ton/ref": 3516.85
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
