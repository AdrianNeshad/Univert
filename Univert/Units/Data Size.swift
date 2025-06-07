//
//  Data Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Datastorlek: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "data_size",
            titleKey: "unit_data_size",
            units: ["b", "B", "KB", "MB", "GB", "TB", "PB", "EB"],
            fullNames: [
                "b": "Bit",
                "B": "Byte",
                "KB": "Kilobyte",
                "MB": "Megabyte",
                "GB": "Gigabyte",
                "TB": "Terabyte",
                "PB": "Petabyte",
                "EB": "Exabyte"
            ],
            convert: { value, from, to in
                let factor: [String: Double] = [
                    "b": 1,
                    "B": 8,
                    "KB": 8 * pow(1024.0, 1),
                    "MB": 8 * pow(1024.0, 2),
                    "GB": 8 * pow(1024.0, 3),
                    "TB": 8 * pow(1024.0, 4),
                    "PB": 8 * pow(1024.0, 5),
                    "EB": 8 * pow(1024.0, 6)
                ]
                guard let fromF = factor[from], let toF = factor[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
