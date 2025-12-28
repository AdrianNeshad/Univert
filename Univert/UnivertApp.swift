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
        let languageCode = preferred.split(separator: "-").first.map(String.init) ?? "en"

        let supportedLanguages: Set<String> = [
            "sv", "de", "fr", "he", "zh", "ar", "ru", "ja", "it",
            "tr", "ko", "pl", "el", "pt", "hi", "bn", "fa", "ti", "nl"
        ]

        appLanguage = supportedLanguages.contains(languageCode) ? languageCode : "en"
    }
}
