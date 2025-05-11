//
//  Units Index.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.

import SwiftUI

struct UnitsListView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var units: [Units] = []
    @State private var searchTerm = ""
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "sv" // default: svenska

    var filteredUnits: [Units] {
        guard !searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return units }
        return units.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }

    var body: some View {
        NavigationView {
            List {
                let groupedUnits = Dictionary(grouping: filteredUnits) { $0.category }
                let categoryOrder = ["monetär", "vanlig", "avancerad"]
                
                ForEach(groupedUnits.keys.sorted { lhs, rhs in
                    categoryOrder.firstIndex(of: lhs) ?? Int.max < categoryOrder.firstIndex(of: rhs) ?? Int.max
                }, id: \.self) { category in
                    Section(header: Text(titleForCategory(category)).font(.caption).foregroundColor(.gray)) {
                        ForEach(groupedUnits[category] ?? [], id: \.name) { unit in
                            NavigationLink(destination: destinationView(for: unit)) {
                                HStack {
                                    Text(unit.icon)
                                    Text(unit.name)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                
                if searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Section {
                        EmptyView()
                    } footer: {
                        VStack(spacing: 4) {
                            Text("© 2025 Univert App - \(appVersion)")
                            Text("Github.com/AdrianNeshad")
                            Text("Linkedin.com/in/adrian-neshad")
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, -100)
                    }
                }
            }
            .navigationTitle(appLanguage == "sv" ? "Enheter" : "Units")
            .searchable(text: $searchTerm, prompt: appLanguage == "sv" ? "Sök enheter" : "Search Units")
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
            loadUnits()
        }
        .onChange(of: appLanguage) { _ in
            loadUnits()
        }
    }
    
    func loadUnits() {
        var currentUnits = Units.preview() // starta med default
        if let data = savedUnitsData,
           let savedUnits = try? JSONDecoder().decode([Units].self, from: data) {
            for i in 0..<currentUnits.count {
                if let savedUnit = savedUnits.first(where: { $0.name == currentUnits[i].name }) {
                    currentUnits[i].isFavorite = savedUnit.isFavorite
                }
            }
        }
        units = currentUnits
    }

    func toggleFavorite(_ unit: Units) {
        if let index = units.firstIndex(where: { $0.name == unit.name }) {
            units[index].isFavorite.toggle()
            if let data = try? JSONEncoder().encode(units) {
                savedUnitsData = data
            }
        }
    }
    func titleForCategory(_ key: String) -> String {
        switch key {
        case "vanlig": return appLanguage == "sv" ? "Vanliga enheter" : "Common Units"
        case "monetär": return appLanguage == "sv" ? "Monetära enheter" : "Monetary Units"
        case "avancerad": return appLanguage == "sv" ? "Avancerade enheter" : "Advanced Units"
        default: return ""
        }
    }
}

private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "Version \(version) (\(build))"
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
    let appLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? "sv"
    switch unit.name {
        
        case appLanguage == "sv" ? "Enhetsmall" : "Template":
        Enhetsmall()
        
        case appLanguage == "sv" ? "Hastighet" : "Speed":
            Hastighet()
        case appLanguage == "sv" ? "Vikt" : "Weight":
            Vikt()
        case appLanguage == "sv" ? "Längd" : "Length":
            Längd()
        case appLanguage == "sv" ? "Tid" : "Time":
            Tid()
        case appLanguage == "sv" ? "Temperatur" : "Temperature":
            Temperatur()
        case appLanguage == "sv" ? "Volym" : "Volume":
            Volym()
        case appLanguage == "sv" ? "Skostorlek" : "Shoe Size":
            Skostorlek()
        case appLanguage == "sv" ? "Datastorlek" : "Data Size":
            Datastorlek()
        case appLanguage == "sv" ? "Dataöverföringshastighet" : "Data Transfer Speed":
            Dataöverföringshastighet()
        case appLanguage == "sv" ? "Tryck" : "Pressure":
            Tryck()
        case appLanguage == "sv" ? "Effekt" : "Power":
            Effekt()
        case appLanguage == "sv" ? "Vridmoment" : "Torque":
            Vridmoment()
        case appLanguage == "sv" ? "Valutor" : "Currency":
            Valuta()
        case appLanguage == "sv" ? "Yta" : "Area":
            Yta()
        case appLanguage == "sv" ? "Krypto" : "Crypto":
            Krypto()
        case appLanguage == "sv" ? "Energi" : "Energy":
            Energi()
        case appLanguage == "sv" ? "Andelar" : "Shares":
            Andelar()
        case appLanguage == "sv" ? "Viskositet (dynamisk)" : "Viscosity (dynamic)":
            ViskositetD()
        case appLanguage == "sv" ? "Viskositet (kinematisk)" : "Viscosity (kinematic)":
            ViskositetK()
        case appLanguage == "sv" ? "Vinklar" : "Angles":
            Vinklar()
        case appLanguage == "sv" ? "Elektrisk ström" : "Electric Current":
            ElektriskStröm()
        case appLanguage == "sv" ? "Elektrisk resistans" : "Electric Resistance":
            ElektriskResistans()
        default:
            UnitsDetailView(unit: unit)
        }
    }
