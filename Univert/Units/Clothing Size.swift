//
//  Clothing Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Klädstorlek: View {
    var body: some View {
        VStack {
            Text("👕")
                .font(.system(size: 100))
            Text("This is the Clothing Sizes page")
                .font(.title)
        }
        .navigationTitle("Klädstorlek")
    }
}

struct Klädstorlek_Previews: PreviewProvider {
    static var previews: some View {
        Klädstorlek()
    }
}
