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
    var subcategory: String?
    
    static func preview() -> [Units] {
        let t = StringManager.shared

        return [
            Units(id: "speed", name: t.get("unit_speed"), icon: "🏎", isFavorite: false, category: "vanlig"),
            Units(id: "weight", name: t.get("unit_weight"), icon: "⚖️", isFavorite: false, category: "vanlig"),
            Units(id: "length", name: t.get("unit_length"), icon: "📏", isFavorite: false, category: "vanlig"),
            Units(id: "time", name: t.get("unit_time"), icon: "⏰", isFavorite: false, category: "vanlig"),
            Units(id: "temperature", name: t.get("unit_temperature"), icon: "🌡", isFavorite: false, category: "vanlig"),
            Units(id: "volume", name: t.get("unit_volume"), icon: "🍷", isFavorite: false, category: "vanlig"),
            Units(id: "shoe_size", name: t.get("unit_shoe_size"), icon: "👟", isFavorite: false, category: "vanlig"),
            Units(id: "data_size", name: t.get("unit_data_size"), icon: "💾", isFavorite: false, category: "avancerad", subcategory: "data"),
            Units(id: "data_transfer_speed", name: t.get("unit_data_transfer_speed"), icon: "🔁", isFavorite: false, category: "avancerad", subcategory: "data"),
            Units(id: "pressure", name: t.get("unit_pressure"), icon: "🧭", isFavorite: false, category: "avancerad"),
            Units(id: "power", name: t.get("unit_power"), icon: "⚡️", isFavorite: false, category: "avancerad"),
            Units(id: "torque", name: t.get("unit_torque"), icon: "🔩", isFavorite: false, category: "avancerad"),
            Units(id: "currency", name: t.get("unit_currency"), icon: "💲", isFavorite: false, category: "monetär"),
            Units(id: "area", name: t.get("unit_area"), icon: "🗺️", isFavorite: false, category: "vanlig"),
            Units(id: "crypto_beta", name: t.get("unit_crypto_beta"), icon: "💲", isFavorite: false, category: "monetär"),
            Units(id: "energy", name: t.get("unit_energy"), icon: "🔋", isFavorite: false, category: "avancerad"),
            Units(id: "shares", name: t.get("unit_shares"), icon: "➗", isFavorite: false, category: "avancerad"),
            Units(id: "viscosity_dynamic", name: t.get("unit_viscosity_dynamic"), icon: "💧", isFavorite: false, category: "avancerad", subcategory: "vätska"),
            Units(id: "viscosity_kinematic", name: t.get("unit_viscosity_kinematic"), icon: "💧", isFavorite: false, category: "avancerad", subcategory: "vätska"),
            Units(id: "angles", name: t.get("unit_angles"), icon: "📐", isFavorite: false, category: "avancerad"),
            Units(id: "electric_current", name: t.get("unit_electric_current"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "electric_resistance", name: t.get("unit_electric_resistance"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "numeral_system", name: t.get("unit_numeral_system"), icon: "🔢", isFavorite: false, category: "avancerad"),
            Units(id: "magnetomotive_force", name: t.get("unit_magnetomotive_force"), icon: "🧲", isFavorite: false, category: "avancerad", subcategory: "magnetism"),
            Units(id: "magnetic_field_strength", name: t.get("unit_magnetic_field_strength"), icon: "🧲", isFavorite: false, category: "avancerad", subcategory: "magnetism"),
            Units(id: "magnetic_flux", name: t.get("unit_magnetic_flux"), icon: "🧲", isFavorite: false, category: "avancerad", subcategory: "magnetism"),
            Units(id: "image_resolution", name: t.get("unit_image_resolution"), icon: "🌇", isFavorite: false, category: "avancerad"),
            Units(id: "inductance", name: t.get("unit_inductance"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "charge", name: t.get("unit_charge"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "linear_charge", name: t.get("unit_linear_charge"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "surface_charge", name: t.get("unit_surface_charge"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "volume_charge", name: t.get("unit_volume_charge"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "magnetic_flux_density", name: t.get("unit_magnetic_flux_density"), icon: "🧲", isFavorite: false, category: "avancerad", subcategory: "magnetism"),
            Units(id: "radiation", name: t.get("unit_radiation"), icon: "☢️", isFavorite: false, category: "avancerad", subcategory: "strålning"),
            Units(id: "radiation_activity", name: t.get("unit_radiation_activity"), icon: "☢️", isFavorite: false, category: "avancerad", subcategory: "strålning"),
            Units(id: "radiation_exposure", name: t.get("unit_radiation_exposure"), icon: "☢️", isFavorite: false, category: "avancerad", subcategory: "strålning"),
            Units(id: "radiation_absorbed", name: t.get("unit_radiation_absorbed"), icon: "☢️", isFavorite: false, category: "avancerad", subcategory: "strålning"),
            Units(id: "linear_current", name: t.get("unit_linear_current"), icon: "⚡️", isFavorite: false, category: "avancerad", subcategory: "elektricitet"),
            Units(id: "surface_tension", name: t.get("unit_surface_tension"), icon: "💧", isFavorite: false, category: "avancerad", subcategory: "vätska"),
            Units(id: "flow_rate", name: t.get("unit_flow_rate"), icon: "💧", isFavorite: false, category: "avancerad", subcategory: "vätska"),
            Units(id: "concentration_solution", name: t.get("unit_concentration_solution"), icon: "💧", isFavorite: false, category: "avancerad", subcategory: "vätska"),
            Units(id: "mass_flux_density", name: t.get("unit_mass_flux_density"), icon: "💧", isFavorite: false, category: "avancerad", subcategory: "vätska"),
            Units(id: "luminance", name: t.get("unit_luminance"), icon: "💡", isFavorite: false, category: "avancerad", subcategory: "belysning"),
        ]
    }
}
