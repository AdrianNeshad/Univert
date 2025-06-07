//
//  MassFluxDensity.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI

struct MassFluxDensity: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "mass_flux_density",
            titleKey: "unit_mass_flux_density",
            units: [
                "kg/(m²·s)", "g/(cm²·s)", "g/(m²·s)", "mg/(cm²·s)", "mg/(m²·s)", "kg/(cm²·s)"
            ],
            fullNames: [
                "kg/(m²·s)": "Kilogram/square meter/second",
                "g/(cm²·s)": "Gram/square centimeter/second",
                "g/(m²·s)": "Gram/square meter/second",
                "mg/(cm²·s)": "Milligram/square centimete/second",
                "mg/(m²·s)": "Milligram/square meter/second",
                "kg/(cm²·s)": "Kilogram/square centimeter/second"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "kg/(m²·s)": 1.0,
                    "g/(cm²·s)": 10.0,
                    "g/(m²·s)": 0.001,
                    "mg/(cm²·s)": 0.01,
                    "mg/(m²·s)": 0.000001,
                    "kg/(cm²·s)": 10_000.0
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
