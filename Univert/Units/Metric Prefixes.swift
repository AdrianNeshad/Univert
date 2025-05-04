//
//  Metric Prefixes.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct MetricPrefixes: View {
    var body: some View {
        VStack {
            Text("📶")
                .font(.system(size: 100))
            Text("This is the Metric Prefixes page")
                .font(.title)
        }
        .navigationTitle("Metric Prefixes")
    }
}

struct MetricPrefixes_Previews: PreviewProvider {
    static var previews: some View {
        MetricPrefixes()
    }
}
