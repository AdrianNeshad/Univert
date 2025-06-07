//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct Andelar: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "shares",
            titleKey: "unit_shares",
            units: [
                "%", "‰", "mg/Kg", "mg/g", "g/Kg", "ug/Kg", "ug/g",
                "ppm", "ppb", "ppt", "pptr", "ppth", "ppq", "pg/g", "ng/g", "ng/Kg"
            ],
            fullNames: [
                "%": "Percent",
                "‰": "Per Mille",
                "mg/Kg": "Milligram per Kilogram",
                "mg/g": "Milligram per Gram",
                "g/Kg": "Gram per Kilogram",
                "ug/Kg": "Microgram per Kilogram",
                "ug/g": "Microgram per Gram",
                "ppm": "Parts Per Million",
                "ppb": "Parts Per Billion",
                "ppt": "Parts Per Trillion",
                "pptr": "Parts Per Trillion (pptr)",
                "ppth": "Parts Per Thousand (ppth)",
                "ppq": "Parts Per Quadrillion (ppq)",
                "pg/g": "Picogram per Gram",
                "ng/g": "Nanogram per Gram",
                "ng/Kg": "Nanogram per Kilogram"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "%": 1.0,
                    "‰": 0.1,
                    "mg/Kg": 0.0001,
                    "mg/g": 0.1,
                    "g/Kg": 0.1,
                    "ug/Kg": 1e-7,
                    "ug/g": 0.0001,
                    "ppm": 0.0001,
                    "ppb": 1e-7,
                    "ppt": 1e-10,
                    "pptr": 1e-10,
                    "ppth": 0.1,
                    "ppq": 1e-13,
                    "pg/g": 1e-10,
                    "ng/g": 0.0001,
                    "ng/Kg": 1e-7
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else { return nil }
                let valueInPercent = value * fromFactor
                return valueInPercent / toFactor
            },
            maxFractionDigits: 4
        ))
    }
}
