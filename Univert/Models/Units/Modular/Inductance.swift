//
//  Inductance.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Inductance: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "inductance",
            titleKey: "unit_inductance",
            units: [
                "H", "aH", "fH", "pH", "nH", "µH", "mH", "cH", "dH",
                "daH", "hH", "kH", "MH", "GH", "TH", "PH", "EH"
            ],
            fullNames: [
                "aH": "attohenry",
                "fH": "femtohenry",
                "pH": "picohenry",
                "nH": "nanohenry",
                "µH": "microhenry",
                "mH": "millihenry",
                "cH": "centihenry",
                "dH": "decihenry",
                "H": "henry",
                "daH": "decahenry",
                "hH": "hectohenry",
                "kH": "kilohenry",
                "MH": "megahenry",
                "GH": "gigahenry",
                "TH": "terahenry",
                "PH": "petahenry",
                "EH": "exahenry"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "aH": 1e-18, "fH": 1e-15, "pH": 1e-12, "nH": 1e-9,
                    "µH": 1e-6, "mH": 1e-3, "cH": 1e-2, "dH": 1e-1,
                    "H": 1.0, "daH": 1e1, "hH": 1e2, "kH": 1e3,
                    "MH": 1e6, "GH": 1e9, "TH": 1e12, "PH": 1e15, "EH": 1e18
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else {
                    return nil
                }
                return value * fromFactor / toFactor
            },
            maxFractionDigits: 2
        ))
    }
}
