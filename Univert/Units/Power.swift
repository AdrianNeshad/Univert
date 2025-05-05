//
//  Power.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Kraft: View {
    var body: some View {
        VStack {
            Text("⚡️")
                .font(.system(size: 100))
            Text("This is the Power page")
                .font(.title)
        }
        .navigationTitle("Kraft")
    }
}

struct Kraft_Previews: PreviewProvider {
    static var previews: some View {
        Kraft()
    }
}
