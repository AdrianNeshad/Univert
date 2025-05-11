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
            if let data = savedUnitsData,
               let decoded = try? JSONDecoder().decode([Units].self, from: data) {
                favoriter = decoded.filter { $0.isFavorite }
            }
        }
    }
}
