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
        "X": "X",
    ]

    private let en: [String: String] = [
        "X": "X",
    ]

    func get(_ key: String) -> String {
        let table = language == "sv" ? sv : en
        return table[key] ?? key
    }
}
