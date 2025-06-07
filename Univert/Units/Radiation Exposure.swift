//
//  Radiation Exposure.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Radiation_Exposure: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "radiation_exposure",
            titleKey: "unit_radiation_exposure",
            units: ["R", "mR", "µR", "C/kg", "mC/kg", "µC/kg"],
            fullNames: [
                "R": "roentgen",
                "mR": "milliroentgen",
                "µR": "microroentgen",
                "C/kg": "coulomb per kilogram",
                "mC/kg": "millicoulomb per kilogram",
                "µC/kg": "microcoulomb per kilogram"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "R": 1.0,
                    "mR": 1e-3,
                    "µR": 1e-6,
                    "C/kg": 2.58e-4,
                    "mC/kg": 2.58e-7,
                    "µC/kg": 2.58e-10
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
