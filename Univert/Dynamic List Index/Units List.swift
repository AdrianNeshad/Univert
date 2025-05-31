    //
    //  Units.swift
    //  Univert
    //
    //  Created by Adrian Neshad on 2025-05-04.
    //

import Foundation

struct Units: Codable, Identifiable {
    var id: String         
    var name: String
    var icon: String
    var isFavorite: Bool
    var category: String
    
    static func preview() -> [Units] {
        let lang = UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        
        return [
            Units(id: "speed", name: lang == "sv" ? "Hastighet" : "Speed", icon: "🏎", isFavorite: false, category: "vanlig"),
            Units(id: "weight", name: lang == "sv" ? "Vikt" : "Weight", icon: "⚖️", isFavorite: false, category: "vanlig"),
            Units(id: "length", name: lang == "sv" ? "Längd" : "Length", icon: "📏", isFavorite: false, category: "vanlig"),
            Units(id: "time", name: lang == "sv" ? "Tid" : "Time", icon: "⏰", isFavorite: false, category: "vanlig"),
            Units(id: "temperature", name: lang == "sv" ? "Temperatur" : "Temperature", icon: "🌡", isFavorite: false, category: "vanlig"),
            Units(id: "volume", name: lang == "sv" ? "Volym" : "Volume", icon: "🍷", isFavorite: false, category: "vanlig"),
            Units(id: "shoe_size", name: lang == "sv" ? "Skostorlek" : "Shoe Size", icon: "👟", isFavorite: false, category: "vanlig"),
            Units(id: "data_size", name: lang == "sv" ? "Datastorlek" : "Data Size", icon: "💾", isFavorite: false, category: "avancerad"),
            Units(id: "data_transfer_speed", name: lang == "sv" ? "Dataöverföringshastighet" : "Data Transfer Speed", icon: "🔁", isFavorite: false, category: "avancerad"),
            Units(id: "pressure", name: lang == "sv" ? "Tryck" : "Pressure", icon: "🧭", isFavorite: false, category: "avancerad"),
            Units(id: "power", name: lang == "sv" ? "Effekt" : "Power", icon: "⚡️", isFavorite: false, category: "avancerad"),
            Units(id: "torque", name: lang == "sv" ? "Vridmoment" : "Torque", icon: "🔩", isFavorite: false, category: "avancerad"),
            Units(id: "currency", name: lang == "sv" ? "Valuta" : "Currency", icon: "💲", isFavorite: false, category: "monetär"),
            Units(id: "area", name: lang == "sv" ? "Yta" : "Area", icon: "🗺️", isFavorite: false, category: "vanlig"),
            Units(id: "crypto_beta", name: lang == "sv" ? "Krypto (beta)" : "Crypto (beta)", icon: "💲", isFavorite: false, category: "monetär"),
            Units(id: "energy", name: lang == "sv" ? "Energi" : "Energy", icon: "🔋", isFavorite: false, category: "avancerad"),
            Units(id: "shares", name: lang == "sv" ? "Andelar" : "Shares", icon: "➗", isFavorite: false, category: "avancerad"),
            Units(id: "viscosity_dynamic", name: lang == "sv" ? "Viskositet (dynamisk)" : "Viscosity (dynamic)", icon: "💧", isFavorite: false, category: "avancerad"),
            Units(id: "viscosity_kinematic", name: lang == "sv" ? "Viskositet (kinematisk)" : "Viscosity (kinematic)", icon: "💧", isFavorite: false, category: "avancerad"),
            Units(id: "angles", name: lang == "sv" ? "Vinklar" : "Angles", icon: "📐", isFavorite: false, category: "avancerad"),
            Units(id: "electric_current", name: lang == "sv" ? "Elektrisk ström" : "Electric Current", icon: "⚡️", isFavorite: false, category: "avancerad"),
            Units(id: "electric_resistance", name: lang == "sv" ? "Elektrisk resistans" : "Electric Resistance", icon: "⚡️", isFavorite: false, category: "avancerad"),
            Units(id: "numeral_system", name: lang == "sv" ? "Talsystem" : "Numeral System", icon: "🔢", isFavorite: false, category: "avancerad"),
            Units(id: "magnetomotive_force", name: lang == "sv" ? "Magnetomotorisk kraft" : "Magnetomotive Force", icon: "🧲", isFavorite: false, category: "avancerad"),
            Units(id: "magnetic_field_strength", name: lang == "sv" ? "Magnetisk fältstyrka" : "Magnetic Field Strength", icon: "🧲", isFavorite: false, category: "avancerad"),
            Units(id: "magnetic_flux", name: lang == "sv" ? "Magnetflöde" : "Magnetic Flux", icon: "🧲", isFavorite: false, category: "avancerad"),
            Units(id: "image_resolution", name: lang == "sv" ? "Digital bildupplösning" : "Digital Image Resolution", icon: "🌇", isFavorite: false, category: "avancerad")
        ]
    }
}
