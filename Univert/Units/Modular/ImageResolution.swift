//
//  ImageResolution.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-31.
//

import SwiftUI

struct ImageResolution: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "image_resolution",
            titleKey: "unit_image_resolution",
            units: ["ppi", "dpi", "dpm", "dpmm"],
            fullNames: [
                "ppi": "pixel/inch",
                "dpi": "dot/inch",
                "dpm": "dot/meter",
                "dpmm": "dot/millimeter"
            ],
            convert: { value, from, to in
                let toPPI: [String: Double] = [
                    "ppi": 1.0,
                    "dpi": 1.0,
                    "dpm": 0.0254,
                    "dpmm": 25.4
                ]
                guard let fromFactor = toPPI[from], let toFactor = toPPI[to] else { return nil }
                let valueInPPI = value * fromFactor
                return valueInPPI / toFactor
            },
            maxFractionDigits: 2
        ))
    }
}
