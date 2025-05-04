//
//  Units Index.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.

import SwiftUI

struct UnitsListView: View {
    @State private var units = Units.preview()

    var body: some View {
        NavigationView {
        List(units, id: \.name) {
            food in HStack {
                Text(units.icon)
                Text(units.name)
            }
        }
        .toolbar {
            Button {
                
                let newUnits = Units(name: "New", icon: "?")
                withAnimation {
                    units.append(newUnits)
                }
                
            } label: {
                Label("Add", systemImage: "plus")
            }
        }
    }
    }
}

struct UnitsListView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsListView()
    }
}
