    //
//  Luminous_flux.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-08.
//

import SwiftUI

struct LuminousFlux: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "luminous_flux",
            titleKey: "unit_luminous_flux",
            units: [
                "lm", "klm", "Mlm", "cd·sr", "lx·m²", "ph"
            ],
            fullNames: [
                "lm": "Lumen",
                "klm": "Kilolumen",
                "Mlm": "Megalumen",
                "cd·sr": "Candela steradian",
                "lx·m²": "Lux meter²",
                "ph": "Phot"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "lm": 1.0,
                    "klm": 1e3,
                    "Mlm": 1e6,
                    "cd·sr": 1.0,
                    "lx·m²": 1.0,
                    "ph": 10000.0
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
