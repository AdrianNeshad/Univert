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
            .navigationTitle("Enheter")
            .searchable(text: $searchTerm, prompt: "Sök enheter")
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
    case "Velocitet":
        Velocitet()
    case "Vikt":
        Vikt()
    case "Längd":
        Längd()
    case "Tid":
        Tid()
    case "Temperatur":
        Temperatur()
    case "Volym":
        Volym()
    case "Skostorlek":
        Skostorlek()
    case "Datastorlek":
        Datastorlek()
    case "Dataöverföringshastighet":
        Dataöverföringshastighet()
    case "Tryck":
        Tryck()
    case "Kraft":
        Kraft()
    case "Vridmoment":
        Vridmoment()
    case "Valuta":
        Valuta()
    case "Enhetsmall":
        Enhetsmall()
    case "Yta":
        Yta()
    default:
        UnitsDetailView(unit: unit) // fallback om ingen matchar
    }
}
