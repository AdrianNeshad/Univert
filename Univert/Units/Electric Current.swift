//
//  Electric Current.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-11.
//

import SwiftUI

struct ElektriskStröm: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "electric_current",
            titleKey: "unit_electric_current",
            units: ["A", "kA", "mA", "Bi", "abA", "emuI", "statA", "esuI", "CGSem", "CGSes"],
            fullNames: [
                "A": "Ampere",
                "kA": "Kiloampere",
                "mA": "Milliampere",
                "Bi": "Biot",
                "abA": "Abampere",
                "emuI": "EMU of current",
                "statA": "Statampere",
                "esuI": "ESU of current",
                "CGSem": "CGS e.m. unit",
                "CGSes": "CGS e.s. unit"
            ],
            convert: { value, from, to in
                let factors: [String: Double] = [
                    "A": 1.0,
                    "kA": 1000.0,
                    "mA": 0.001,
                    "Bi": 10.0,
                    "abA": 10.0,
                    "emuI": 10.0,
                    "statA": 3.335641e-10,
                    "esuI": 3.335641e-10,
                    "CGSem": 10.0,
                    "CGSes": 3.335641e-10
                ]
                guard let fromFactor = factors[from], let toFactor = factors[to] else { return nil }
                return value * fromFactor / toFactor
            },
            maxFractionDigits: 2
        ))
    }
}
