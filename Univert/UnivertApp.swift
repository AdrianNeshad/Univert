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
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false

    var body: some Scene {
        WindowGroup {
            UnitsListView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .onAppear {
                    if !hasLaunchedBefore {
                        setLanguageFromSystem()
                        hasLaunchedBefore = true
                    }
                }
        }
    }

    func setLanguageFromSystem() {
        let preferred = Locale.preferredLanguages.first ?? "en"
        if preferred.starts(with: "sv") {
            appLanguage = "sv"
        } else if preferred.starts(with: "de") {
            appLanguage = "de"
        } else if preferred.starts(with: "fr") {
            appLanguage = "fr"
        } else if preferred.starts(with: "es") {
            appLanguage = "es"
        } else {
            appLanguage = "en"
        }
    }
}
