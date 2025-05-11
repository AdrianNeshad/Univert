//
//  Language.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-11.
//

import SwiftUI

class StringManager {
    static let shared = StringManager()
    @AppStorage("appLanguage") var language: String = "sv"
    
    private let sv: [String: String] = [
        "settings_title": "Inställningar",
        "dark_mode": "Mörkt läge",
        "language": "Språk",
        "decimal_setting": "Använd svensk decimal (,)",
        "units_title": "Enheter",
        "from": "Från",
        "to": "Till",
        "favorites": "Favoriter",
        "search_units": "Sök enheter",
        "value": "Värde",
        "you_have_no_favorites": "Du har inte lagt till favoriter ännu"
    ]

    private let en: [String: String] = [
        "settings_title": "Settings",
        "dark_mode": "Dark mode",
        "language": "Language",
        "decimal_setting": "Use Swedish decimal (,)",
        "units_title": "Units",
        "from": "From",
        "to": "To",
        "favorites": "Favorites",
        "search_units": "Search units",
        "value": "Value",
        "you_have_no_favorites": "You have not added any favorites yet"
    ]

    func get(_ key: String) -> String {
        let table = language == "sv" ? sv : en
        return table[key] ?? key
    }
}
