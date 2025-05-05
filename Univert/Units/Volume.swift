//
//  Volume.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Volym: View {
    var body: some View {
        VStack {
            Text("🍷")
                .font(.system(size: 100))
            Text("This is the Volume page")
                .font(.title)
        }
        .navigationTitle("Volym")
    }
}

struct Volume_Previews: PreviewProvider {
    static var previews: some View {
        Volym()
    }
}
