//
//  LockedUnitRow.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-15.
//

import SwiftUI

struct LockedUnitRow: View {
    let unit: Units
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(unit.icon)
            Text(unit.name)
            Spacer()
            Image(systemName: "lock.fill")
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}
