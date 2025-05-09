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
    
    var body: some View {
        List {
            if favoriter.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "star")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("Du har inte lagt till favoriter ännu")
                        .font(.body)
                        .foregroundColor(.gray)
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
        .navigationTitle("Favoriter")
        .onAppear {
            if let data = savedUnitsData,
               let decoded = try? JSONDecoder().decode([Units].self, from: data) {
                favoriter = decoded.filter { $0.isFavorite }
            }
        }
    }
}
