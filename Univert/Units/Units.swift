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
    // var isFavorite: Bool
    
    static func preview() -> [Units] {
        [Units(name: "Mass", icon: "⚖️"),
         Units(name: "Length", icon: "📐"),
         Units(name: "Time", icon: "⏱"),
         Units(name: "Temperature", icon: "🌡"),
         Units(name: "Volume", icon: "🍷"),
        ]
    }
}
