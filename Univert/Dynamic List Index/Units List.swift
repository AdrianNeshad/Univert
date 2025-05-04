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
         Units(name: "Velocity", icon: "🏎", isFavorite: false),
         Units(name: "Length", icon: "📐", isFavorite: false),
         Units(name: "Time", icon: "⏰", isFavorite: false),
         Units(name: "Temperature", icon: "🌡", isFavorite: false),
         Units(name: "Volume", icon: "🍷", isFavorite: false),
         Units(name: "Shoe Size", icon: "👟", isFavorite: false),
         Units(name: "Data Size", icon: "💾", isFavorite: false),
         Units(name: "Data Transfer Speed", icon: "🔁", isFavorite: false),
         Units(name: "Pressure", icon: "🧭", isFavorite: false),
         Units(name: "Power", icon: "⚡️", isFavorite: false),
         Units(name: "Torque", icon: "⚙️", isFavorite: false),
         Units(name: "Metric Prefixes", icon: "📶", isFavorite: false),
         Units(name: "Clothing Sizes", icon: "👕", isFavorite: false),
        ]
    }
}
