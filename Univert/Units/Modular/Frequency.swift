//
//  Frequency.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-08.
//

import SwiftUI

struct Frequency: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "frequency",
            titleKey: "unit_frequency",
            units: ["Hz", "aHz", "fHz", "pHz", "nHz", "µHz", "mHz", "cHz", "dHz", "daHz", "hHz", "kHz", "MHz", "GHz", "THz", "PHz", "EHz"],
            fullNames: [
                "aHz": "Attohertz",
                "fHz": "Femtohertz",
                "pHz": "Picohertz",
                "nHz": "Nanohertz",
                "µHz": "Microhertz",
                "mHz": "Millihertz",
                "cHz": "Centihertz",
                "dHz": "Decihertz",
                "Hz": "Hertz",
                "daHz": "Decahertz",
                "hHz": "Hectohertz",
                "kHz": "Kilohertz",
                "MHz": "Megahertz",
                "GHz": "Gigahertz",
                "THz": "Terahertz",
                "PHz": "Petahertz",
                "EHz": "Exahertz"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "aHz": 1e-18,
                    "fHz": 1e-15,
                    "pHz": 1e-12,
                    "nHz": 1e-9,
                    "µHz": 1e-6,
                    "mHz": 1e-3,
                    "cHz": 1e-2,
                    "dHz": 1e-1,
                    "Hz": 1.0,
                    "daHz": 1e1,
                    "hHz": 1e2,
                    "kHz": 1e3,
                    "MHz": 1e6,
                    "GHz": 1e9,
                    "THz": 1e12,
                    "PHz": 1e15,
                    "EHz": 1e18
                ]
                guard let fromF = factors[from], let toF = factors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 6
        ))
    }
}
