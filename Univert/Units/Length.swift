//
//  Length.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Length: View {
    var body: some View {
        VStack {
            Text("📐")
                .font(.system(size: 100))
            Text("This is the Length page")
                .font(.title)
        }
        .navigationTitle("Length")
    }
}

struct Length_Previews: PreviewProvider {
    static var previews: some View {
        Length()
    }
}
