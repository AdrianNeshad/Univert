//
//  Velocity.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Hastighet: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "speed",
            titleKey: "unit_speed",
            units: [
                "km/h", "mph", "m/s", "m/h", "m/min", "knot", "km/min", "km/s",
                "cm/h", "cm/min", "cm/s", "mm/h", "mm/min", "mm/s",
                "ft/h", "ft/min", "ft/s", "yd/h", "yd/min", "yd/s",
                "mi/min", "mi/s", "kn(UK)", "c", "v1", "v2", "v3",
                "vE", "vs(w)", "vs(sw)", "M", "M(SI)"
            ],
            fullNames: [
                "m/s": "meter/second",
                "km/h": "kilometer/hour",
                "mph": "mile/hour",
                "m/h": "meter/hour",
                "m/min": "meter/minute",
                "km/min": "kilometer/minute",
                "km/s": "kilometer/second",
                "cm/h": "centimeter/hour",
                "cm/min": "centimeter/minute",
                "cm/s": "centimeter/second",
                "mm/h": "millimeter/hour",
                "mm/min": "millimeter/minute",
                "mm/s": "millimeter/second",
                "ft/h": "foot/hour",
                "ft/min": "foot/minute",
                "ft/s": "foot/second",
                "yd/h": "yard/hour",
                "yd/min": "yard/minute",
                "yd/s": "yard/second",
                "mi/min": "mile/minute",
                "mi/s": "mile/second",
                "knot": "knot",
                "kn(UK)": "knot (UK)",
                "c": "Velocity of light in vacuum",
                "v1": "Cosmic velocity - first",
                "v2": "Cosmic velocity - second",
                "v3": "Cosmic velocity - third",
                "vE": "Earth's velocity",
                "vs(w)": "Velocity of sound in pure water",
                "vs(sw)": "Velocity of sound in sea water",
                "M": "Mach (20°C, 1 atm)",
                "M(SI)": "Mach (SI standard)"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "km/h": 1.0,
                    "mph": 1.60934,
                    "m/s": 3.6,
                    "m/min": 0.06,
                    "m/h": 0.001,
                    "km/s": 3600.0,
                    "km/min": 60.0,
                    "cm/h": 0.00001,
                    "cm/min": 0.0006,
                    "cm/s": 0.036,
                    "mm/h": 0.000001,
                    "mm/min": 0.00006,
                    "mm/s": 0.0036,
                    "ft/h": 0.0003048,
                    "ft/min": 0.018287,
                    "ft/s": 1.09728,
                    "yd/h": 0.0009144,
                    "yd/min": 0.054864,
                    "yd/s": 3.29184,
                    "mi/min": 96.5604,
                    "mi/s": 5793.62,
                    "knot": 1.852,
                    "kn(UK)": 1.85328,
                    "c": 1.079e+9,
                    "v1": 28.44,
                    "v2": 39.87,
                    "v3": 52.0,
                    "vE": 107218,
                    "vs(w)": 5.4,
                    "vs(sw)": 5.35,
                    "M": 1225.044,
                    "M(SI)": 1234.8
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
