//
//  ConcentrationSolution.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI

struct ConcentrationSolution: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "concentration_solution",
            titleKey: "unit_concentration_solution",
            units: [
                "mol/L", "mmol/L", "mol/m³", "g/L", "mg/L", "µg/L", "ppm", "ppb", "% w/w", "% w/v", "% v/v"
            ],
            fullNames: [
                "mol/L": "Molarity (mol/iter)",
                "mmol/L": "Millimolarity (mmol/liter)",
                "mol/m³": "Mole/cubic meter",
                "g/L": "Gram/liter",
                "mg/L": "Milligram/liter",
                "µg/L": "Microgram/liter",
                "ppm": "Parts per million",
                "ppb": "Parts per billion",
                "% w/w": "Percent weight/weight",
                "% w/v": "Percent weight/volume",
                "% v/v": "Percent volume/volume"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "mol/L": 1.0,
                    "mmol/L": 1e-3,
                    "mol/m³": 1.0 / 1000.0,
                    "g/L": 1.0 / 18.01528,
                    "mg/L": 1.0 / 18.01528 / 1000.0,
                    "µg/L": 1.0 / 18.01528 / 1000000.0,
                    "ppm": 1.0 / 18.01528 / 1000.0,
                    "ppb": 1.0 / 18.01528 / 1000000.0,
                    "% w/w": 10.0 / 18.01528,
                    "% w/v": 1.0 / 18.01528,
                    "% v/v": 1.0 / 18.01528
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
