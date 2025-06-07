//
//  Charge.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Charge: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "charge",
            titleKey: "unit_charge",
            units: ["c", "aC", "fC", "pC", "nC", "µC", "mC", "kC", "MC", "Ah"],
            fullNames: [
                "aC": "attoCoulomb",
                "fC": "femtoCoulomb",
                "pC": "picoCoulomb",
                "nC": "nanoCoulomb",
                "µC": "microCoulomb",
                "mC": "milliCoulomb",
                "c": "Coulomb",
                "kC": "kiloCoulomb",
                "MC": "megaCoulomb",
                "Ah": "ampere-hour"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "aC": 1e-18,
                    "fC": 1e-15,
                    "pC": 1e-12,
                    "nC": 1e-9,
                    "µC": 1e-6,
                    "mC": 1e-3,
                    "c": 1.0,
                    "kC": 1e3,
                    "MC": 1e6,
                    "Ah": 3600.0
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
