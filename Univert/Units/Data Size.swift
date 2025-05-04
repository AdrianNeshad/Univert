//
//  Data Size.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct DataSize: View {
    var body: some View {
        VStack {
            Text("💾")
                .font(.system(size: 100))
            Text("This is the Data Size page")
                .font(.title)
        }
        .navigationTitle("Data Size")
    }
}

struct DataSize_Previews: PreviewProvider {
    static var previews: some View {
        DataSize()
    }
}
