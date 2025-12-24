//
//  UnitRow.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-15.
//

import SwiftUI

struct UnitRow: View {
    let unit: Units
    
    var body: some View {
        HStack {
            Text(unit.icon)
            Text(unit.name)
            Spacer()
        }
    }
}
