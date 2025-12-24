//
//  Surface Tension.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI

struct SurfaceTension: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "surface_tension",
            titleKey: "unit_surface_tension",
            units: ["N/m", "dyne/cm", "mN/m", "lbf/ft", "lbf/in", "kgf/m", "kgf/cm"],
            fullNames: [
                "N/m": "Newton/meter",
                "dyne/cm": "Dyne/centimeter",
                "mN/m": "Millinewton/meter",
                "lbf/ft": "Pound-force/foot",
                "lbf/in": "Pound-force/inch",
                "kgf/m": "Kilogram-force/meter",
                "kgf/cm": "Kilogram-force/centimeter"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "N/m": 1.0,
                    "dyne/cm": 0.001,
                    "mN/m": 0.001,
                    "lbf/ft": 14.5939029,
                    "lbf/in": 175.126834,
                    "kgf/m": 9.80665,
                    "kgf/cm": 980.665      
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
