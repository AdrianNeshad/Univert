//
//  Time.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Tid: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "time",
            titleKey: "unit_time",
            units: ["ms", "s", "min", "h", "d", "w", "m", "yr"],
            fullNames: [
                "ms": "Millisecond",
                "s": "Second",
                "min": "Minute",
                "h": "Hour",
                "d": "Day",
                "w": "Week",
                "m": "Month",
                "yr": "Year"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "s": 1,
                    "ms": 0.001,
                    "min": 60,
                    "h": 3600,
                    "d": 86400,
                    "w": 604800,
                    "m": 2592000,
                    "yr": 31536000
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
