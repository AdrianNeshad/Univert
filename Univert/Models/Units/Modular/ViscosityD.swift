//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct ViskositetD: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "viscosity_dynamic",
            titleKey: "unit_viscosity_dynamic",
            units: [
                "Pa s", "kgf s/m²", "N s/m²", "mN s/m²", "dyne s/cm²",
                "P", "EP", "PP", "TP", "GP", "MP", "kP", "hP", "daP", "dP", "cP", "mP",
                "µP", "nP", "pP", "fP", "aP",
                "lbf s/in²", "lbf s/ft²", "pdl s/ft²", "g/cm/s", "slug/ft/s", "lb/ft/s", "lb/ft/h"
            ],
            fullNames: [
                "Pa s": "Pascal-second",
                "kgf s/m²": "Kilogram-force second/square meter",
                "N s/m²": "Newton second/square meter",
                "mN s/m²": "Millinewton second/square meter",
                "dyne s/cm²": "Dyne second/square centimeter",
                "P": "Poise",
                "EP": "Exapoise", "PP": "Petapoise", "TP": "Terapoise", "GP": "Gigapoise",
                "MP": "Megapoise", "kP": "Kilopoise", "hP": "Hectopoise", "daP": "Dekapoise",
                "dP": "Decipoise", "cP": "Centipoise", "mP": "Millipoise", "µP": "Micropoise",
                "nP": "Nanopoise", "pP": "Picopoise", "fP": "Femtopoise", "aP": "Attopoise",
                "lbf s/in²": "Pound-force second/square inch",
                "lbf s/ft²": "Pound-force second/square foot",
                "pdl s/ft²": "Poundal second/square foot",
                "g/cm/s": "Gram per centimeter/second",
                "slug/ft/s": "Slug per foot/second",
                "lb/ft/s": "Pound per foot/second",
                "lb/ft/h": "Pound per foot/hour"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "Pa s": 1.0,
                    "kgf s/m²": 9.80665,
                    "N s/m²": 1.0,
                    "mN s/m²": 0.001,
                    "dyne s/cm²": 0.1,
                    "P": 0.1,
                    "EP": 1.0E+17, "PP": 1.0E+14, "TP": 1.0E+11, "GP": 1.0E+8,
                    "MP": 1.0E+5, "kP": 100, "hP": 10, "daP": 1,
                    "dP": 0.01, "cP": 0.001, "mP": 0.0001,
                    "µP": 1.0E-7, "nP": 1.0E-10, "pP": 1.0E-13,
                    "fP": 1.0E-16, "aP": 1.0E-19,
                    "lbf s/in²": 6894.7572931684,
                    "lbf s/ft²": 47.8802589802,
                    "pdl s/ft²": 1.4881639436,
                    "g/cm/s": 0.1,
                    "slug/ft/s": 47.8802589802,
                    "lb/ft/s": 1.4881639436,
                    "lb/ft/h": 0.0004133789
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
