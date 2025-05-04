//
//  Torque.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Torque: View {
    var body: some View {
        VStack {
            Text("⚙️")
                .font(.system(size: 100))
            Text("This is the Torque page")
                .font(.title)
        }
        .navigationTitle("Torque")
    }
}

struct Torque_Previews: PreviewProvider {
    static var previews: some View {
        Torque()
    }
}
