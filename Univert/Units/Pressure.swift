//
//  Pressure.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Pressure: View {
    var body: some View {
        VStack {
            Text("🧭")
                .font(.system(size: 100))
            Text("This is the Pressure page")
                .font(.title)
        }
        .navigationTitle("Pressure")
    }
}

struct Pressure_Previews: PreviewProvider {
    static var previews: some View {
        Pressure()
    }
}
