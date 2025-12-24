//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct Enhetsmall: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "enhetsmall",
            titleKey: "unit_template",
            units: ["XXX", "YYY", "ZZZ"],
            fullNames: [
                "XXX": "XXX",
                "YYY": "YYY",
                "ZZZ": "ZZZ"
            ],
            convert: { value, from, to in
                let conversionFactors: [String: Double] = [
                    "XXX": 1.0,
                    "YYY": 10.0,
                    "ZZZ": 100.0
                ]
                guard let fromF = conversionFactors[from], let toF = conversionFactors[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
