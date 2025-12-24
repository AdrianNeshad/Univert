//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct ElektriskResistans: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "electric_resistance",
            titleKey: "unit_electric_resistance",
            units: ["Ω", "MΩ", "µΩ", "V/A", "S⁻¹", "abΩ", "emuR", "statΩ", "esuR", "RH"],
            fullNames: [
                "Ω": "Ohm",
                "MΩ": "Megohm",
                "µΩ": "Microhm",
                "V/A": "Volt per Ampere",
                "S⁻¹": "Reciprocal Siemens",
                "abΩ": "Abohm",
                "emuR": "EMU of resistance",
                "statΩ": "Statohm",
                "esuR": "ESU of resistance",
                "RH": "Quantized Hall resistance"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "Ω": 1.0,
                    "MΩ": 1000000.0,
                    "µΩ": 1e-6,
                    "V/A": 1.0,
                    "S⁻¹": 1.0,
                    "abΩ": 1e-9,
                    "emuR": 1e-9,
                    "statΩ": 8.98755179e11,
                    "esuR": 8.98755179e11,
                    "RH": 25812.80745
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
