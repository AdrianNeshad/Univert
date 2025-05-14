//
//  Favorites.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-09.
//

import SwiftUI

struct Favoriter: View {
    @AppStorage("savedUnits") private var savedUnitsData: Data?
    @State private var favoriter: [Units] = []
    @AppStorage("appLanguage") private var appLanguage = "sv" // default: svenska
    
    let unitNamePairs: [String: String] = [
        "Hastighet": "Speed",
        "Vikt": "Weight",
        "Längd": "Length",
        "Tid": "Time",
        "Temperatur": "Temperature",
        "Volym": "Volume",
        "Skostorlek": "Shoe Size",
        "Datastorlek": "Data Size",
        "Dataöverföringshastighet": "Data Transfer Speed",
        "Tryck": "Pressure",
        "Effekt": "Power",
        "Vridmoment": "Torque",
        "Valuta": "Currency",
        "Yta": "Area",
        "Krypto": "Crypto",
        "Energi": "Energy",
        "Andelar": "Shares",
        "Viskositet (dynamisk)": "Viscosity (dynamic)",
        "Viskositet (kinematisk)": "Viscosity (kinematic)",
        "Vinklar": "Angles",
        "Elektrisk ström": "Electric Current",
        "Elektrisk resistans": "Electric Resistance",
        "Talsystem": "Numeral System"
    ]
    
    var body: some View {
        List {
            if favoriter.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "star")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text(appLanguage == "sv" ? "Du har inte lagt till någon enhet till favoriter ännu" : "You have not added any unit to your favorites")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 50)
            } else {
                ForEach(favoriter, id: \.name) { unit in
                    NavigationLink(destination: destinationView(for: unit)) {
                        HStack {
                            Text(unit.icon)
                            Text(unit.name)
                        }
                    }
                }
            }        }
        .navigationTitle(appLanguage == "sv" ? "Favoriter" : "Favorites")
        .onAppear {
            let previewUnits = Units.preview() // rätt språk just nu
            
            if let data = savedUnitsData,
               let savedUnits = try? JSONDecoder().decode([Units].self, from: data) {
                
                favoriter = previewUnits.filter { previewUnit in
                    savedUnits.contains { saved in
                        // Jämför både svenska och engelska namn
                        let savedName = saved.name
                        let translated = unitNamePairs[savedName] ?? unitNamePairs.first(where: { $0.value == savedName })?.key
                        return (saved.isFavorite && (
                            savedName == previewUnit.name ||
                            translated == previewUnit.name
                        ))
                    }
                }
            }
        }

    }
}
