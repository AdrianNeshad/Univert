//
//  Temperature.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Temperatur: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "temperature",
            titleKey: "unit_temperature",
            units: ["°C", "°F", "K"],
            fullNames: [
                "°C": "Celsius",
                "°F": "Fahrenheit",
                "K": "Kelvin"
            ],
            convert: { value, from, to in
                switch (from, to) {
                case ("°C", "°F"):
                    return (value * 9/5) + 32
                case ("°F", "°C"):
                    return (value - 32) * 5/9
                case ("°C", "K"):
                    return value + 273.15
                case ("K", "°C"):
                    return value - 273.15
                case ("°F", "K"):
                    return (value - 32) * 5/9 + 273.15
                case ("K", "°F"):
                    return (value - 273.15) * 9/5 + 32
                default:
                    return value
                }
            },
            maxFractionDigits: 2
        ))
    }
}
