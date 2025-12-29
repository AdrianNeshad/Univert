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
    @AppStorage("appLanguage") private var appLanguage = "en"
        
    var body: some View {
        List {
            if favoriter.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "star")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text(StringManager.shared.get("notaddedfavorites"))
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 50)
            } else {
                ForEach(favoriter, id: \.id) { unit in
                    NavigationLink(destination: destinationView(for: unit)) {
                        HStack {
                            Text(unit.icon)
                            Text(unit.name)
                        }
                    }
                }
            }
        }
        .navigationTitle(StringManager.shared.get("favorites"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadFavorites()
        }
    }
    
    private func loadFavorites() {
        let previewUnits = Units.preview()
        
        guard let data = savedUnitsData,
              let savedUnits = try? JSONDecoder().decode([Units].self, from: data) else {
            favoriter = []
            return
        }
        
        favoriter = previewUnits.filter { previewUnit in
            savedUnits.contains { saved in
                saved.isFavorite && saved.id == previewUnit.id
            }
        }
    }
}
