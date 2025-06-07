//
//  Magnetic Flux.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-14.
//

import SwiftUI

struct Magnetflöde: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "magnetic_flux",
            titleKey: "unit_magnetic_flux",
            units: ["Wb", "mWb", "μWb", "V·s", "MΦ", "kΦ", "Φ", "Mx", "T·m²", "T·cm²", "G·cm²", "Φ₀"],
            fullNames: [
                "Wb": "Weber",
                "mWb": "Milliweber",
                "μWb": "Microweber",
                "V·s": "Volt-second",
                "MΦ": "Megaline",
                "kΦ": "Kiloline",
                "Φ": "Line",
                "Mx": "Maxwell",
                "T·m²": "Tesla square meter",
                "T·cm²": "Tesla square centimeter",
                "G·cm²": "Gauss square centimeter",
                "Φ₀": "Magnetic flux quantum"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "Wb": 1.0,
                    "mWb": 1e-3,
                    "μWb": 1e-6,
                    "V·s": 1.0,
                    "MΦ": 1e-2,
                    "kΦ": 1e-5,
                    "Φ": 1e-8,
                    "Mx": 1e-8,
                    "T·m²": 1.0,
                    "T·cm²": 1e-4,
                    "G·cm²": 1e-8,
                    "Φ₀": 2.067833848e-15
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else { return nil }
                return value * fromFactor / toFactor
            },
            maxFractionDigits: 4
        ))
    }
}
