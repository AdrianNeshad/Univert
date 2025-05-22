//
//  UnivertApp.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

@main
struct UnivertApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
 
    var body: some Scene {
        WindowGroup {
            UnitsListView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
