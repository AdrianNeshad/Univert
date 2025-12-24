//
//  Radiation Activity.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-06-06.
//

import SwiftUI

struct Radiation_Activity: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "radiation_activity",
            titleKey: "unit_radiation_activity",
            units: ["Bq", "kBq", "MBq", "GBq", "TBq", "Ci", "mCi", "µCi", "nCi", "pCi"],
            fullNames: [
                "Bq": "becquerel",
                "kBq": "kilobecquerel",
                "MBq": "megabecquerel",
                "GBq": "gigabecquerel",
                "TBq": "terabecquerel",
                "Ci": "curie",
                "mCi": "millicurie",
                "µCi": "microcurie",
                "nCi": "nanocurie",
                "pCi": "picocurie"
            ],
            convert: { value, from, to in
                let map: [String: Double] = [
                    "Bq": 1.0,
                    "kBq": 1e3,
                    "MBq": 1e6,
                    "GBq": 1e9,
                    "TBq": 1e12,
                    "Ci": 3.7e10,
                    "mCi": 3.7e7,
                    "µCi": 3.7e4,
                    "nCi": 3.7e1,
                    "pCi": 3.7e-2
                ]
                guard let fromF = map[from], let toF = map[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 4
        ))
    }
}
