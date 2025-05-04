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
            List(units, id: \.name) { unit in
                NavigationLink(destination: destinationView(for: unit)) {
                    HStack {
                        Text(unit.icon)
                        Text(unit.name)
                    }
                }
            }
            .navigationTitle("Units")
        }
    }
}

struct UnitsDetailView: View {
    let unit: Units

    var body: some View {
        VStack {
            Text(unit.icon)
                .font(.largeTitle)
            Text(unit.name)
                .font(.title)
        }
        .navigationTitle(unit.name)
    }
}

struct UnitsListView_Previews: PreviewProvider {
    static var previews: some View {
        UnitsListView()
    }
}

@ViewBuilder
func destinationView(for unit: Units) -> some View {
    switch unit.name {
    case "Mass":
        Mass()
    case "Length":
        Length()
    case "Time":
        Time()
    case "Temperature":
        Temperature()
    case "Volume":
        Volume()
    default:
        UnitsDetailView(unit: unit) // fallback om ingen matchar
    }
}
