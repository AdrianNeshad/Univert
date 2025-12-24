//
//  Angles.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-11.
//

import SwiftUI

struct Vinklar: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "angles",
            titleKey: "unit_angles",
            units: [
                "°", "rad", "grad", "'", "\"", "gon", "sign", "mil",
                "rev", "⊙", "tr", "quad", "right angle"
            ],
            fullNames: [
                "°": "Degree",
                "rad": "Radian",
                "grad": "Grad",
                "'": "Minute",
                "\"": "Second",
                "gon": "Gon",
                "sign": "Sign",
                "mil": "Mil",
                "rev": "Revolution",
                "⊙": "Circle",
                "tr": "Turn",
                "quad": "Quadrant",
                "right angle": "Right angle"
            ],
            convert: { value, from, to in
                let deg: [String: Double] = [
                    "°": 1.0,
                    "rad": 180.0 / .pi,
                    "grad": 0.9,
                    "'": 1 / 60.0,
                    "\"": 1 / 3600.0,
                    "gon": 0.9,
                    "sign": 30.0,
                    "mil": 0.05625,
                    "rev": 360.0,
                    "⊙": 360.0,
                    "tr": 360.0,
                    "quad": 90.0,
                    "right angle": 90.0
                ]
                guard let fromF = deg[from], let toF = deg[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
