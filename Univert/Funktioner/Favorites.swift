//
//  Favorites.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-09.
//

import SwiftUI
import SwiftUI

struct Favoriter: View {
    var body: some View {
        Form {
            Text("Favoriter-funktion kommer snart")
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
        .navigationTitle("Favoriter")
    }
}
