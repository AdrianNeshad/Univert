//
//  Units.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import Foundation

struct Units: Codable {
    var name: String
    var icon: String
    var isFavorite: Bool
    
    static func preview() -> [Units] {
        let lang = UserDefaults.standard.string(forKey: "appLanguage") ?? "sv"
        
        return [
            Units(name: lang == "sv" ? "Hastighet" : "Speed", icon: "🏎", isFavorite: false),
            Units(name: lang == "sv" ? "Vikt" : "Weight", icon: "⚖️", isFavorite: false),
            Units(name: lang == "sv" ? "Längd" : "Length", icon: "📏", isFavorite: false),
            Units(name: lang == "sv" ? "Tid" : "Time", icon: "⏰", isFavorite: false),
            Units(name: lang == "sv" ? "Temperatur" : "Temperature", icon: "🌡", isFavorite: false),
            Units(name: lang == "sv" ? "Volym" : "Volume", icon: "🍷", isFavorite: false),
            Units(name: lang == "sv" ? "Skostorlek" : "Shoe Size", icon: "👟", isFavorite: false),
            Units(name: lang == "sv" ? "Datastorlek" : "Data Size", icon: "💾", isFavorite: false),
            Units(name: lang == "sv" ? "Dataöverföringshastighet" : "Data Transfer Speed", icon: "🔁", isFavorite: false),
            Units(name: lang == "sv" ? "Tryck" : "Pressure", icon: "🧭", isFavorite: false),
            Units(name: lang == "sv" ? "Effekt" : "Power", icon: "⚡️", isFavorite: false),
            Units(name: lang == "sv" ? "Vridmoment" : "Torque", icon: "🔩", isFavorite: false),
            Units(name: lang == "sv" ? "Valuta" : "Currency", icon: "💲", isFavorite: false),
            Units(name: lang == "sv" ? "Yta" : "Area", icon: "🗺️", isFavorite: false),
            Units(name: lang == "sv" ? "Krypto" : "Crypto", icon: "💲", isFavorite: false),
            Units(name: lang == "sv" ? "Energi" : "Energy", icon: "🔋", isFavorite: false),
            Units(name: lang == "sv" ? "Andelar" : "Shares", icon: "➗", isFavorite: false),
            Units(name: lang == "sv" ? "Viskositet (dynamisk)" : "Viscosity (dynamic)", icon: "💧", isFavorite: false),
            Units(name: lang == "sv" ? "Viskositet (kinematisk)" : "Viscosity (kinematic)", icon: "💧", isFavorite: false),
            Units(name: lang == "sv" ? "Vinklar" : "Angles", icon: "📐", isFavorite: false),
            Units(name: lang == "sv" ? "Elektrisk ström" : "Electric Current", icon: "⚡️", isFavorite: false),
            Units(name: lang == "sv" ? "Elektrisk resistans" : "Electric Resistance", icon: "⚡️", isFavorite: false)
        ]
    }

}
