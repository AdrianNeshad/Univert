//
//  Temperature.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Temperature: View {
    var body: some View {
        VStack {
            Text("🌡")
                .font(.system(size: 100))
            Text("This is the Temperature page")
                .font(.title)
        }
        .navigationTitle("Temperature")
    }
}

struct Temperature_Previews: PreviewProvider {
    static var previews: some View {
        Temperature()
    }
}
