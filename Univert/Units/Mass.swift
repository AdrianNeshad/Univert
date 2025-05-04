//
//  Mass.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Mass: View {
    var body: some View {
        VStack {
            Text("⚖️")
                .font(.system(size: 100))
            Text("This is the Mass page")
                .font(.title)
        }
        .navigationTitle("Mass")
    }
}

struct Mass_Previews: PreviewProvider {
    static var previews: some View {
        Mass()
    }
}
