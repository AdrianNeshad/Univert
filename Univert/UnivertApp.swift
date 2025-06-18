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
        } else if preferred.starts(with: "he") {
            appLanguage = "he" // Hebreiska
        } else if preferred.starts(with: "zh") {
            appLanguage = "zh" // Kinesiska
        } else if preferred.starts(with: "ar") {
            appLanguage = "ar" // Arabiska
        } else if preferred.starts(with: "ru") {
            appLanguage = "ru" // Ryska
        } else if preferred.starts(with: "ja") {
            appLanguage = "ja" // Japanska
        } else if preferred.starts(with: "it") {    
            appLanguage = "it" // Italienska
        } else if preferred.starts(with: "tr") {
            appLanguage = "tr" // Turkiska
        } else if preferred.starts(with: "ko") {
            appLanguage = "ko" // Koreanska
        } else if preferred.starts(with: "pl") {
            appLanguage = "pl" // Polska
        } else if preferred.starts(with: "el") {
            appLanguage = "el" // Grekiska
        } else if preferred.starts(with: "pt") {
            appLanguage = "pt" // Portugisiska
        } else if preferred.starts(with: "hi") {
            appLanguage = "hi" // Hindi
        } else if preferred.starts(with: "bn") {
            appLanguage = "bn" // Bengali
        } else if preferred.starts(with: "fa") {
            appLanguage = "fa" // Farsi
        } else if preferred.starts(with: "ti") {
            appLanguage = "ti" // Tigrinja
        } else if preferred.starts(with: "nl") {
            appLanguage = "nl" // nederländska
        } else {
            appLanguage = "en"
        }
    }
}
