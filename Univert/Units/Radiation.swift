//
//  Radiation.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Radiation: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "radiation",
            titleKey: "unit_radiation",
            units: [
                "Gy/s", "Gy/min", "Gy/h",
                "mGy/s", "mGy/min", "mGy/h",
                "µGy/s", "µGy/min", "µGy/h",
                "rad/s", "rad/min", "rad/h"
            ],
            fullNames: [
                "Gy/s": "gray per second",
                "Gy/min": "gray per minute",
                "Gy/h": "gray per hour",
                "mGy/s": "milligray per second",
                "mGy/min": "milligray per minute",
                "mGy/h": "milligray per hour",
                "µGy/s": "microgray per second",
                "µGy/min": "microgray per minute",
                "µGy/h": "microgray per hour",
                "rad/s": "rad per second",
                "rad/min": "rad per minute",
                "rad/h": "rad per hour"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "Gy/s": 1.0,
                    "Gy/min": 1.0 / 60.0,
                    "Gy/h": 1.0 / 3600.0,
                    "mGy/s": 1e-3,
                    "mGy/min": 1e-3 / 60.0,
                    "mGy/h": 1e-3 / 3600.0,
                    "µGy/s": 1e-6,
                    "µGy/min": 1e-6 / 60.0,
                    "µGy/h": 1e-6 / 3600.0,
                    "rad/s": 0.01,
                    "rad/min": 0.01 / 60.0,
                    "rad/h": 0.01 / 3600.0
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
