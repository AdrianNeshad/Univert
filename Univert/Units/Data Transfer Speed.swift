//
//  Data Transfer Speed.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct DataTransferSpeed: View {
    var body: some View {
        VStack {
            Text("🔁")
                .font(.system(size: 100))
            Text("This is the Data Transfer Speed page")
                .font(.title)
        }
        .navigationTitle("Data Transfer Speed")
    }
}

struct DataTransferSpeed_Previews: PreviewProvider {
    static var previews: some View {
        DataTransferSpeed()
    }
}
