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

    init() {
        #if targetEnvironment(simulator)
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "savedUnits")
        defaults.removeObject(forKey: "appLanguage")
        defaults.removeObject(forKey: "advancedUnitsUnlocked")
        defaults.removeObject(forKey: "isDarkMode")
        defaults.synchronize()
        print("UserDefaults reset in simulator")
        #endif
    }

    var body: some Scene {
        WindowGroup {
            UnitsListView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
