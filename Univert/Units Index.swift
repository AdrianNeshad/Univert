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
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    
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
                                                Spacer()
                                                Button(action: {
                                                    toggleFavorite(unit)
                                                }) {
                                                    Image(systemName: unit.isFavorite ? "star.fill" : "star")
                                                        .foregroundColor(.yellow)
                                                }
                                                .buttonStyle(BorderlessButtonStyle())
                                            }
                                        }                }

                Section {
                    EmptyView()
                } footer: {
                    VStack(spacing: 4) {
                        Text("© 2025 Univert App")
                        Text("Github.com/AdrianNeshad")
                        Text("Linkedin.com/in/adrian-neshad")
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
                    NavigationLink(destination: Favoriter()) {
                        Image(systemName: "star")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Inställningar()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
                    if let data = savedUnitsData,
                       let decoded = try? JSONDecoder().decode([Units].self, from: data) {
                        units = decoded
                    } else {
                        units = Units.preview()
                    }
                }

    }
    func toggleFavorite(_ unit: Units) {
            if let index = units.firstIndex(where: { $0.name == unit.name }) {
                units[index].isFavorite.toggle()
                if let data = try? JSONEncoder().encode(units) {
                    savedUnitsData = data
                }
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
