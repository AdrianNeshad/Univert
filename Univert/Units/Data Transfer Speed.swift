//
//  Data Transfer Speed.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Dataöverföringshastighet: View {
    var body: some View {
        UnitConverterView(definition: UnitDefinition(
            id: "data_transfer_speed",
            titleKey: "unit_data_transfer_speed",
            units: [
                "bit/s", "Byte/s", "Kbit/s", "KB/s", "Mbit/s", "MB/s",
                "Gbit/s", "GB/s", "Tbit/s", "TB/s"
            ],
            fullNames: [
                "bit/s": "Bit/second",
                "Byte/s": "Byte/second",
                "Kbit/s": "Kilobit/second",
                "KB/s": "Kilobyte/second",
                "Mbit/s": "Megabit/second",
                "MB/s": "Megabyte/second",
                "Gbit/s": "Gigabit/second",
                "GB/s": "Gigabyte/second",
                "Tbit/s": "Terabit/second",
                "TB/s": "Terabyte/second"
            ],
            convert: { value, from, to in
                let factor: [String: Double] = [
                    "bit/s": 1,
                    "Byte/s": 8,
                    "Kbit/s": 1000,
                    "KB/s": 8 * 1000,
                    "Mbit/s": 1000000,
                    "MB/s": 8 * 1000000,
                    "Gbit/s": 1000000000,
                    "GB/s": 8 * 1000000000,
                    "Tbit/s": 1000000000000,
                    "TB/s": 8 * 1000000000000
                ]
                guard let fromF = factor[from], let toF = factor[to] else { return nil }
                return value * fromF / toF
            },
            maxFractionDigits: 2
        ))
    }
}
