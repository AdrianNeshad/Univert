//
//  UnitsListView.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI
import StoreKit

struct UnitsListView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    @State private var units: [Units] = []
    @State private var searchTerm = ""
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @AppStorage("appLanguage") private var appLanguage = "en"
    @State private var showPurchaseSheet = false
    @StateObject private var storeManager = StoreManager()
    @AppStorage("advancedUnitsUnlocked") private var advancedUnitsUnlocked = false

    var filteredUnits: [Units] {
        guard !searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return units }
        return units.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
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
                        ForEach(groupedUnits[category] ?? [], id: \.id) { unit in
                            if category == "avancerad" && !advancedUnitsUnlocked {
                                LockedUnitRow(unit: unit) {
                                    showPurchaseSheet = true
                                }
                            } else {
                                NavigationLink(destination: destinationView(for: unit)) {
                                    UnitRow(unit: unit)
                                }
                            }
                        }
                    }
                }
                
                if searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    AppFooter()
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
            .sheet(isPresented: $showPurchaseSheet) {
                PurchaseView(storeManager: storeManager, isUnlocked: $advancedUnitsUnlocked)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onAppear {
            loadUnits()
            storeManager.getProducts(productIDs: ["Univert.AdvancedUnits"])
        }
        .onChange(of: appLanguage) { _ in
            loadUnits()
        }
    }
    
    func migrateSavedUnitsIfNeeded() {
        let previewUnits = Units.preview()
        
        var savedUnits: [Units] = []
        if let data = savedUnitsData,
           let decoded = try? JSONDecoder().decode([Units].self, from: data) {
            savedUnits = decoded
        }
        
        savedUnits = savedUnits.filter { saved in
            previewUnits.contains(where: { $0.id == saved.id })
        }
        
        for unit in previewUnits {
            if !savedUnits.contains(where: { $0.id == unit.id }) {
                savedUnits.append(unit)
            }
        }
        
        if savedUnits.count != previewUnits.count {
            if let encoded = try? JSONEncoder().encode(savedUnits) {
                savedUnitsData = encoded
            }
        }
        
        units = savedUnits
    }
    
    func loadUnits() {
        migrateSavedUnitsIfNeeded()
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
    switch unit.id {
    case "speed":
        Hastighet()
    case "weight":
        Vikt()
    case "length":
        Längd()
    case "time":
        Tid()
    case "temperature":
        Temperatur()
    case "volume":
        Volym()
    case "shoe_size":
        Skostorlek()
    case "data_size":
        Datastorlek()
    case "data_transfer_speed":
        Dataöverföringshastighet()
    case "pressure":
        Tryck()
    case "power":
        Effekt()
    case "torque":
        Vridmoment()
    case "currency":
        Valuta()
    case "area":
        Yta()
    case "crypto_beta":
        Krypto()
    case "energy":
        Energi()
    case "shares":
        Andelar()
    case "viscosity_dynamic":
        ViskositetD()
    case "viscosity_kinematic":
        ViskositetK()
    case "angles":
        Vinklar()
    case "electric_current":
        ElektriskStröm()
    case "electric_resistance":
        ElektriskResistans()
    case "numeral_system":
        Talsystem()
    case "magnetomotive_force":
        Magnetomotorisk()
    case "magnetic_field_strength":
        MagnetiskFältstyrka()
    case "magnetic_flux":
        Magnetflöde()
    case "image_resolution":
        ImageResolution()
    default:
        UnitsDetailView(unit: unit)
    }
}

