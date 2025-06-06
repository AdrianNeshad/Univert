//
//  Language.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-11.
//

import SwiftUI

class StringManager {
    static let shared = StringManager()
    @AppStorage("appLanguage") var language: String = "en"
    
    private let sv: [String: String] = [
        "settings": "Inställningar"
    ]
    
    private let en: [String: String] = [
        "settings": "Settings"
    ]
    
    private let de: [String: String] = [
        "settings": "Einstellungen"
    ]
    
    private let es: [String: String] = [
        "settings": "Ajustes"
    ]
    
    private let fr: [String: String] = [
        "settings": "Paramètres"
    ]
    
    private var tables: [String: [String: String]] {
        [
            "sv": sv,
            "en": en,
            "de": de,
            "es": es,
            "fr": fr
        ]
    }

    func get(_ key: String) -> String {
        tables[language]?[key] ?? key
    }
}
