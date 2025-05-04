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
        [Units(name: "Mass", icon: "⚖️", isFavorite: false),
         Units(name: "Length", icon: "📐", isFavorite: false),
         Units(name: "Time", icon: "⏱", isFavorite: false),
         Units(name: "Temperature", icon: "🌡", isFavorite: false),
         Units(name: "Volume", icon: "🍷", isFavorite: false),
        ]
    }
}
