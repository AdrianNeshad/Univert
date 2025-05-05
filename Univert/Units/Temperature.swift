//
//  Temperature.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Temperatur: View {
    var body: some View {
        VStack {
            Text("🌡")
                .font(.system(size: 100))
            Text("This is the Temperature page")
                .font(.title)
        }
        .navigationTitle("Temperatur")
    }
}

struct Temperatur_Previews: PreviewProvider {
    static var previews: some View {
        Temperatur()
    }
}
