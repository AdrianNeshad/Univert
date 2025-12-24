//
//  Magnetic Flux Density.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Magnetic_Flux_Density: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "magnetic_flux_density",
            titleKey: "unit_magnetic_flux_density",
            units: ["T", "mT", "µT", "nT", "pT", "fT", "aT", "G", "mG", "kG"],
            fullNames: [
                "T": "tesla",
                "mT": "millitesla",
                "µT": "microtesla",
                "nT": "nanotesla",
                "pT": "picotesla",
                "fT": "femtotesla",
                "aT": "attotesla",
                "G": "gauss",
                "mG": "milligauss",
                "kG": "kilogauss"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "T": 1.0,
                    "mT": 1e-3,
                    "µT": 1e-6,
                    "nT": 1e-9,
                    "pT": 1e-12,
                    "fT": 1e-15,
                    "aT": 1e-18,
                    "G": 1e-4,
                    "mG": 1e-7,
                    "kG": 1e-1
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
