//
//  Energy.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-08.
//

import SwiftUI

struct Energi: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "energy",
            titleKey: "unit_energy",
            units: ["J", "kJ", "kWh", "Wh", "cal", "kcal", "Btu"],
            fullNames: [
                "J": "Joule",
                "kJ": "Kilojoule",
                "kWh": "Kilowatt-hour",
                "Wh": "Watt-hour",
                "cal": "Calorie",
                "kcal": "Kilocalorie",
                "Btu": "British Thermal Unit"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "J": 1,
                    "kJ": 1000,
                    "kWh": 3600000,
                    "Wh": 3600,
                    "cal": 4.184,
                    "kcal": 4184,
                    "Btu": 1055.06
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else { return nil }
                return value * fromFactor / toFactor
            },
            maxFractionDigits: 4
        ))
    }
}
