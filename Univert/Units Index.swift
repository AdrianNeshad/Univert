//
//  Units Index.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.

import SwiftUI

struct UnitsListView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var units = Units.preview()
    @State private var searchTerm = ""
    
    var filteredUnits: [Units] {
        guard !searchTerm.isEmpty else { return units }
        return units.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }

    var body: some View {
        NavigationView {
            List {
                // Huvudinnehåll
                ForEach(filteredUnits.sorted(by: { $0.name < $1.name }), id: \.name) { unit in
                    NavigationLink(destination: destinationView(for: unit)) {
                        HStack {
                            Text(unit.icon)
                            Text(unit.name)
                        }
                    }
                }

                Section {
                    EmptyView()
                } footer: {
                    VStack(spacing: 4) {
                        Text("© 2025 Univert App - Adrian Neshad")
                        Text("Github.com/AdrianNeshad")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, -100)
                }
            }
            .navigationTitle("Enheter")
            .searchable(text: $searchTerm, prompt: "Sök enheter")
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Toggle(isOn: $isDarkMode) {
                                    Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                                }
                                .toggleStyle(SwitchToggleStyle(tint: .blue))
                            }
                        }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
        Group {
            UnitsListView()
                .preferredColorScheme(.light)
                .previewDisplayName("Ljust läge")
            
            UnitsListView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Mörkt läge")
        }
    }
}



@ViewBuilder
func destinationView(for unit: Units) -> some View {
    switch unit.name {
    case "Hastighet":
        Hastighet()
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
    case "Effekt":
        Effekt()
    case "Vridmoment":
        Vridmoment()
    case "Valuta":
        Valuta()
    case "Yta":
        Yta()
    case "Krypto":
        Krypto()
    case "Energi":
        Energi()
    default:
        UnitsDetailView(unit: unit) // fallback om ingen matchar
    }
}
