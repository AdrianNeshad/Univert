//
//  Units.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import Foundation

struct Units {
    var name: String
    var icon: String
    var isFavorite: Bool
    
    static func preview() -> [Units] {
        [Units(name: "Velocitet", icon: "🏎", isFavorite: false),
         Units(name: "Vikt", icon: "⚖️", isFavorite: false),
         Units(name: "Längd", icon: "📐", isFavorite: false),
         Units(name: "Tid", icon: "⏰", isFavorite: false),
         Units(name: "Temperatur", icon: "🌡", isFavorite: false),
         Units(name: "Volym", icon: "🍷", isFavorite: false),
         Units(name: "Skostorlek", icon: "👟", isFavorite: false),
         Units(name: "Datastorlek", icon: "💾", isFavorite: false),
         Units(name: "Dataöverföringshastighet", icon: "🔁", isFavorite: false),
         Units(name: "Tryck", icon: "🧭", isFavorite: false),
         Units(name: "Kraft", icon: "⚡️", isFavorite: false),
         Units(name: "Vridmoment", icon: "⚙️", isFavorite: false),
         Units(name: "Valuta", icon: "💲", isFavorite: false),
         Units(name: "Enhetsmall", icon: "❌", isFavorite: false),
         Units(name: "Yta", icon: "🗺️", isFavorite: false),
        ]
    }
}
