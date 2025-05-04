//
//  Units Index.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.

import SwiftUI

struct UnitsListView: View {
    @State private var units = Units.preview()
    @State private var searchTerm = ""
    
    var filteredUnits: [Units] {
        guard !searchTerm.isEmpty else { return units }
        return units.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }

    var body: some View {
        NavigationView {
            List(filteredUnits.sorted(by: { $0.name < $1.name }), id: \.name) { unit in
                NavigationLink(destination: destinationView(for: unit)) {
                    HStack {
                        Text(unit.icon)
                        Text(unit.name)
                    }
                }
            }
            .navigationTitle("Units")
            .searchable(text: $searchTerm, prompt: "Search Units")
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
    case "Velocity":
        Velocity()
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
    case "Shoe Size":
        ShoeSize()
    case "Data Size":
        DataSize()
    case "Data Transfer Speed":
        DataTransferSpeed()
    case "Pressure":
        Pressure()
    case "Power":
        Power()
    case "Torque":
        Torque()
    case "Metric Prefixes":
        MetricPrefixes()
    case "Clothing Sizes":
        ClothingSizes()
    default:
        UnitsDetailView(unit: unit) // fallback om ingen matchar
    }
}
