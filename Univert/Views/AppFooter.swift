//
//  AppFooter.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-15.
//

import SwiftUI

struct AppFooter: View {
    var body: some View {
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
        }
    }
}
