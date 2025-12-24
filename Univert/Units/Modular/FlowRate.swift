//
//  FlowRate.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-07.
//

import SwiftUI

struct FlowRate: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "flow_rate",
            titleKey: "unit_flow_rate",
            units: [
                "m³/s", "m³/min", "m³/h", "L/s", "L/min", "L/h", "mL/s", "mL/min", "mL/h",
                "ft³/s", "ft³/min", "ft³/h", "in³/s", "in³/min", "in³/h", "GPM", "MGD"
            ],
            fullNames: [
                "m³/s": "Cubic meter/second",
                "m³/min": "Cubic meter/minute",
                "m³/h": "Cubic meter/hour",
                "L/s": "Liter/second",
                "L/min": "Liter/minute",
                "L/h": "Liter/hour",
                "mL/s": "Milliliter/second",
                "mL/min": "Milliliter/minute",
                "mL/h": "Milliliter/hour",
                "ft³/s": "Cubic foot/second",
                "ft³/min": "Cubic foot/minute",
                "ft³/h": "Cubic foot/hour",
                "in³/s": "Cubic inch/second",
                "in³/min": "Cubic inch/minute",
                "in³/h": "Cubic inch/hour",
                "GPM": "Gallons/minute",
                "MGD": "Million gallons/day"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "m³/s": 1.0,
                    "m³/min": 1.0 / 60.0,
                    "m³/h": 1.0 / 3600.0,
                    "L/s": 0.001,
                    "L/min": 0.001 / 60.0,
                    "L/h": 0.001 / 3600.0,
                    "mL/s": 1e-6,
                    "mL/min": 1e-6 / 60.0,
                    "mL/h": 1e-6 / 3600.0,
                    "ft³/s": 0.028316846592,
                    "ft³/min": 0.028316846592 / 60.0,
                    "ft³/h": 0.028316846592 / 3600.0,
                    "in³/s": 1.6387064e-5,
                    "in³/min": 1.6387064e-5 / 60.0,
                    "in³/h": 1.6387064e-5 / 3600.0,
                    "GPM": 0.003785411784 / 60.0,
                    "MGD": 0.003785411784 * 1_000_000 / 86400.0
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
