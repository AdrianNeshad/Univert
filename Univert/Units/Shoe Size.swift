//
//  Shoe Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct ShoeSize: View {
    var body: some View {
        VStack {
            Text("👟")
                .font(.system(size: 100))
            Text("This is the Shoe Size page")
                .font(.title)
        }
        .navigationTitle("Shoe Size")
    }
}

struct ShoeSize_Previews: PreviewProvider {
    static var previews: some View {
        ShoeSize()
    }
}
