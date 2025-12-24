//
//  Volume charge.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Volume_charge: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "volume_charge",
            titleKey: "unit_volume_charge",
            units: ["C/m³", "mC/m³", "µC/m³", "nC/m³", "pC/m³", "fC/m³", "aC/m³"],
            fullNames: [
                "C/m³": "coulombs/m³",
                "mC/m³": "millicoulombs/m³",
                "µC/m³": "microcoulombs/m³",
                "nC/m³": "nanocoulombs/m³",
                "pC/m³": "picocoulombs/m³",
                "fC/m³": "femtocoulombs/m³",
                "aC/m³": "attocoulombs/m³"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "C/m³": 1.0,
                    "mC/m³": 1e-3,
                    "µC/m³": 1e-6,
                    "nC/m³": 1e-9,
                    "pC/m³": 1e-12,
                    "fC/m³": 1e-15,
                    "aC/m³": 1e-18
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
