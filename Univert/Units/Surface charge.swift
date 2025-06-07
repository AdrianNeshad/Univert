//
//  Surface charge.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Surface_charge: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "surface_charge",
            titleKey: "unit_surface_charge",
            units: ["C/m²", "mC/m²", "µC/m²", "nC/m²", "pC/m²", "fC/m²", "aC/m²"],
            fullNames: [
                "C/m²": "coulombs/m²",
                "mC/m²": "millicoulombs/m²",
                "µC/m²": "microcoulombs/m²",
                "nC/m²": "nanocoulombs/m²",
                "pC/m²": "picocoulombs/m²",
                "fC/m²": "femtocoulombs/m²",
                "aC/m²": "attocoulombs/m²"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "C/m²": 1.0,
                    "mC/m²": 1e-3,
                    "µC/m²": 1e-6,
                    "nC/m²": 1e-9,
                    "pC/m²": 1e-12,
                    "fC/m²": 1e-15,
                    "aC/m²": 1e-18
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
