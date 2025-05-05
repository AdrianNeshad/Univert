//
//  Time.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Tid: View {
    var body: some View {
        VStack {
            Text("⏰")
                .font(.system(size: 100))
            Text("This is the Time page")
                .font(.title)
        }
        .navigationTitle("Tid")
    }
}

struct Tid_Previews: PreviewProvider {
    static var previews: some View {
        Tid()
    }
}
