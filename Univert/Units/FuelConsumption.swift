//
//  FuelConsumption.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-08.
//

import SwiftUI

struct FuelConsumption: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "fuel_consumption",
            titleKey: "unit_fuel_consumption",
            units: ["L/100km", "km/L", "mpg (US)", "mpg (UK)"],
            fullNames: [
                "L/100km": "Liters/100 kilometers",
                "km/L": "Kilometers/liter",
                "mpg (US)": "Miles/gallon (US)",
                "mpg (UK)": "Miles/gallon (UK)"
            ],
            convert: { value, from, to in
                let toLPer100km: (Double) -> Double = { value in
                    switch from {
                        case "L/100km": return value
                        case "km/L": return 100.0 / value
                        case "mpg (US)": return 235.214583 / value
                        case "mpg (UK)": return 282.480936 / value
                        default: return value
                    }
                }
                let fromLPer100km: (Double) -> Double = { value in
                    switch to {
                        case "L/100km": return value
                        case "km/L": return 100.0 / value
                        case "mpg (US)": return 235.214583 / value
                        case "mpg (UK)": return 282.480936 / value
                        default: return value
                    }
                }

                guard value != 0 else { return nil }

                let base = toLPer100km(value)
                return fromLPer100km(base)
            },
            maxFractionDigits: 2
        ))
    }
}
