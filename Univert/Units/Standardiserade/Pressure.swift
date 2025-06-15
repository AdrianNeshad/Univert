//
//  Pressure.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Tryck: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "pressure",
            titleKey: "unit_pressure",
            units: ["bar", "psi", "kPa", "atm", "mbar", "MPa", "Pa"],
            fullNames: [
                "bar": "Bar",
                "psi": "Psi",
                "kPa": "Kilopascal",
                "atm": "Atmosphere",
                "mbar": "Millibar",
                "MPa": "Megapascal",
                "Pa": "Pascal"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "bar": 100000,
                    "psi": 6894.76,
                    "kPa": 1000,
                    "atm": 101325,
                    "mbar": 100,
                    "MPa": 1000000,
                    "Pa": 1
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
