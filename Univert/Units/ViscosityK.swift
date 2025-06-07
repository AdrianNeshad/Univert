//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct ViskositetK: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "viscosity_kinematic",
            titleKey: "unit_viscosity_kinematic",
            units: [
                "m²/s", "m²/h", "cm²/s", "mm²/s", "ft²/s", "ft²/h", "in²/s",
                "St", "ESt", "PSt", "TSt", "GSt", "MSt", "kSt", "hSt", "daSt",
                "dSt", "cSt", "mSt", "µSt", "nSt", "pSt", "fSt", "aSt"
            ],
            fullNames: [
                "m²/s": "Square meter/second",
                "m²/h": "Square meter/hour",
                "cm²/s": "Square centimeter/second",
                "mm²/s": "Square millimeter/second",
                "ft²/s": "Square foot/second",
                "ft²/h": "Square foot/hour",
                "in²/s": "Square inch/second",
                "St": "Stokes",
                "ESt": "Exastokes", "PSt": "Petastokes", "TSt": "Terastokes",
                "GSt": "Gigastokes", "MSt": "Megastokes", "kSt": "Kilostokes",
                "hSt": "Hectostokes", "daSt": "Dekastokes", "dSt": "Decistokes",
                "cSt": "Centistokes", "mSt": "Millistokes", "µSt": "Microstokes",
                "nSt": "Nanostokes", "pSt": "Picostokes", "fSt": "Femtostokes", "aSt": "Attostokes"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "m²/s": 1.0,
                    "m²/h": 0.0002777778,
                    "cm²/s": 0.0001,
                    "mm²/s": 1.0E-6,
                    "ft²/s": 0.09290304,
                    "ft²/h": 2.58064E-5,
                    "in²/s": 0.00064516,
                    "St": 0.0001,
                    "ESt": 1.0E+14,
                    "PSt": 1.0E+11,
                    "TSt": 1.0E+8,
                    "GSt": 1.0E+5,
                    "MSt": 100.0,
                    "kSt": 0.1,
                    "hSt": 0.01,
                    "daSt": 0.001,
                    "dSt": 1.0E-5,
                    "cSt": 1.0E-6,
                    "mSt": 1.0E-7,
                    "µSt": 1.0E-10,
                    "nSt": 1.0E-13,
                    "pSt": 1.0E-16,
                    "fSt": 1.0E-19,
                    "aSt": 1.0E-22
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
