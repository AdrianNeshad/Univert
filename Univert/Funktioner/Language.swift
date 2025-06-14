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
        "settings": "Inställningar",
        "otherapps": "Andra appar",
        "univertfeedback": "Univert feedback",
        "givefeedback": "Ge feedback",
        "checkoutunivert": "Kolla in Univert appen!",
        "sharetheapp": "Dela appen",
        "ratetheapp": "Betygsätt appen",
        "about": "Om",
        "processing...": "Bearbetar...",
        "purchasecouldntrestore": "Inga köp kunde återställas",
        "restorefailed": "Återställning misslyckades",
        "purchaserestored": "Ditt köp har återställts",
        "restorepurchase": "Återställ köp",
        "advancedunitsunlocked": "Avancerade enheter upplåsta",
        "unlockadvancedunits": "Univert PRO",
        "advancedunits": "Avancerade enheter",
        "cancel": "Avbryt",
        "favoritescleared": "Favoriter rensade",
        "clear": "Rensa",
        "clearfavorites?": "Vill du rensa dina sparade favoriter?",
        "clearfavorites": "Rensa favoriter",
        "favorites": "Favoriter",
        "comma": "Komma decimalseparator",
        "darkmode": "Mörkt läge",
        "appearance": "Utseende",
        "notaddedfavorites": "Du har inte lagt till några favoriter än",
        "purchasefailed": "Köpet misslyckades, försök igen",
        "thanksforpurchase": "Tack för ditt köp!",
        "loading...": "Laddar...",
        "getaccess": "Få tillgång till alla avancerade enheter med ett engångsköp",
        "fluid": "Vätska",
        "electricity": "Elektricitet",
        "magnetism": "Magnetism",
        "monetaryunits": "Monetära enheter",
        "commonunits": "Vanliga enheter",
        "searchunits": "Sök enheter",
        "units": "Enheter",
        "from": "Från",
        "to": "till",
        "value": "Värde",
        "speed": "Hastighet",
        "addedtofavorites": "Tillagd i favoriter",
        "removed": "Borttagen",
        "source": "Källa: Europeiska Centralbanken (Frankfurter)",
        "source2": "Källa: CoinGecko",
        "invalidinput": "Ogiltigt värde",
        "radiation": "Strålning",
        "light": "Belysning",
        
        "unit_speed": "Hastighet",
        "unit_weight": "Vikt",
        "unit_length": "Längd",
        "unit_time": "Tid",
        "unit_temperature": "Temperatur",
        "unit_volume": "Volym",
        "unit_shoe_size": "Skostorlek",
        "unit_data_size": "Datastorlek",
        "unit_data_transfer_speed": "Dataöverföringshastighet",
        "unit_pressure": "Tryck",
        "unit_power": "Effekt",
        "unit_torque": "Vridmoment",
        "unit_currency": "Valuta",
        "unit_area": "Yta",
        "unit_crypto_beta": "Krypto (beta)",
        "unit_energy": "Energi",
        "unit_shares": "Kvot / Proportion",
        "unit_viscosity_dynamic": "Viskositet (dynamisk)",
        "unit_viscosity_kinematic": "Viskositet (kinematisk)",
        "unit_angles": "Vinklar",
        "unit_electric_current": "Elektrisk ström",
        "unit_electric_resistance": "Elektrisk resistans",
        "unit_numeral_system": "Talsystem",
        "unit_magnetomotive_force": "Magnetomotorisk kraft",
        "unit_magnetic_field_strength": "Magnetisk fältstyrka",
        "unit_magnetic_flux": "Magnetflöde",
        "unit_image_resolution": "Bildupplösning",
        "unit_inductance": "Induktans",
        "unit_charge": "Laddning",
        "unit_linear_charge": "Laddningstäthet (linjär)",
        "unit_volume_charge": "Laddningstäthet (volym)",
        "unit_surface_charge": "Laddningstäthet (yta)",
        "unit_magnetic_flux_density": "Magnetisk flödestäthet",
        "unit_radiation": "Strålning",
        "unit_radiation_activity": "Strålningsaktivitet",
        "unit_radiation_exposure": "Strålningsdos (exponering)",
        "unit_radiation_absorbed": "Strålning – Absorberad dos",
        "unit_linear_current": "Strömtäthet (linjär)",
        "unit_surface_tension": "Ytspänning",
        "unit_flow_rate": "Flöde",
        "unit_concentration_solution": "Lösningskoncentration",
        "unit_mass_flux_density": "Massflödestäthet",
        "unit_luminance": "Luminans",
        "unit_luminous_intensity": "Ljusstyrka",
        "unit_luminous_flux": "Ljusflöde",
        "unit_illuminance": "Belysning",
        "unit_frequency": "Frekvens",
        "unit_fuel_consumption": "Bränsleförbrukning",
    ]
    
    private let en: [String: String] = [
        "settings": "Settings",
        "otherapps": "Other apps",
        "univertfeedback": "Univert feedback",
        "givefeedback": "Give feedback",
        "checkoutunivert": "Check out the Univert app!",
        "sharetheapp": "Share the app",
        "ratetheapp": "Rate the app",
        "about": "About",
        "processing...": "Processing...",
        "purchasecouldntrestore": "No purchases could be restored",
        "restorefailed": "Restore failed",
        "purchaserestored": "Your purchase has been restored",
        "restorepurchase": "Restore purchase",
        "advancedunitsunlocked": "Advanced units unlocked",
        "unlockadvancedunits": "Univert PRO",
        "advancedunits": "Advanced units",
        "cancel": "Cancel",
        "favoritescleared": "Favorites cleared",
        "clear": "Clear",
        "clearfavorites?": "Do you want to clear your saved favorites?",
        "clearfavorites": "Clear favorites",
        "favorites": "Favorites",
        "comma": "Comma decimal separator",
        "darkmode": "Dark mode",
        "appearance": "Appearance",
        "notaddedfavorites": "You haven't added any favorites yet",
        "purchasefailed": "Purchase failed, please try again",
        "thanksforpurchase": "Thanks for your purchase!",
        "loading...": "Loading...",
        "getaccess": "Get access to all advanced units with a one-time purchase",
        "fluid": "Fluid",
        "electricity": "Electricity",
        "magnetism": "Magnetism",
        "monetaryunits": "Monetary units",
        "commonunits": "Common units",
        "searchunits": "Search units",
        "units": "Units",
        "from": "From",
        "to": "to",
        "value": "Value",
        "speed": "Speed",
        "addedtofavorites": "Added to favorites",
        "removed": "Removed",
        "source": "Source: European Central Bank (Frankfurter)",
        "source2": "Source: CoinGecko",
        "invalidinput": "Invalid value",
        "radiation": "Radiation",
        "light": "Lighting",

        "unit_speed": "Speed",
        "unit_weight": "Weight",
        "unit_length": "Length",
        "unit_time": "Time",
        "unit_temperature": "Temperature",
        "unit_volume": "Volume",
        "unit_shoe_size": "Shoe Size",
        "unit_data_size": "Data Size",
        "unit_data_transfer_speed": "Data Transfer Speed",
        "unit_pressure": "Pressure",
        "unit_power": "Power",
        "unit_torque": "Torque",
        "unit_currency": "Currency",
        "unit_area": "Area",
        "unit_crypto_beta": "Crypto (beta)",
        "unit_energy": "Energy",
        "unit_shares": "Ratio / Proportion",
        "unit_viscosity_dynamic": "Viscosity (dynamic)",
        "unit_viscosity_kinematic": "Viscosity (kinematic)",
        "unit_angles": "Angles",
        "unit_electric_current": "Electric Current",
        "unit_electric_resistance": "Electric Resistance",
        "unit_numeral_system": "Numeral System",
        "unit_magnetomotive_force": "Magnetomotive Force",
        "unit_magnetic_field_strength": "Magnetic Field Strength",
        "unit_magnetic_flux": "Magnetic Flux",
        "unit_image_resolution": "Image Resolution",
        "unit_inductance": "Inductance",
        "unit_charge": "Charge",
        "unit_linear_charge": "Linear Charge Density",
        "unit_volume_charge": "Volume Charge Density",
        "unit_surface_charge": "Surface Charge Density",
        "unit_magnetic_flux_density": "Magnetic Flux Density",
        "unit_radiation": "Radiation",
        "unit_radiation_activity": "Radiation Activity",
        "unit_radiation_exposure": "Radiation Exposure",
        "unit_radiation_absorbed": "Radiation – Absorbed Dose",
        "unit_linear_current": "Linear Current Density",
        "unit_surface_tension": "Surface Tension",
        "unit_flow_rate": "Flow Rate",
        "unit_concentration_solution": "Concentration (solution)",
        "unit_mass_flux_density": "Mass Flux Density",
        "unit_luminance": "Luminance",
        "unit_luminous_intensity": "Luminous Intensity",
        "unit_luminous_flux": "Luminous Flux",
        "unit_illuminance": "Illuminance",
        "unit_frequency": "Frequency",
        "unit_fuel_consumption": "Fuel Consumption",
    ]

    
    private let de: [String: String] = [
        "settings": "Einstellungen",
        "otherapps": "Andere Apps",
        "univertfeedback": "Univert Feedback",
        "givefeedback": "Feedback geben",
        "checkoutunivert": "Univert-App ansehen!",
        "sharetheapp": "App teilen",
        "ratetheapp": "App bewerten",
        "about": "Über",
        "processing...": "Verarbeitung...",
        "purchasecouldntrestore": "Käufe konnten nicht wiederhergestellt werden",
        "restorefailed": "Wiederherstellung fehlgeschlagen",
        "purchaserestored": "Ihr Kauf wurde wiederhergestellt",
        "restorepurchase": "Kauf wiederherstellen",
        "advancedunitsunlocked": "Erweiterte Einheiten freigeschaltet",
        "unlockadvancedunits": "Univert PRO",
        "advancedunits": "Erweiterte Einheiten",
        "cancel": "Abbrechen",
        "favoritescleared": "Favoriten gelöscht",
        "clear": "Löschen",
        "clearfavorites?": "Möchten Sie Ihre gespeicherten Favoriten löschen?",
        "clearfavorites": "Favoriten löschen",
        "favorites": "Favoriten",
        "comma": "Komma als Dezimaltrennzeichen",
        "darkmode": "Dunkler Modus",
        "appearance": "Erscheinungsbild",
        "notaddedfavorites": "Sie haben noch keine Favoriten hinzugefügt",
        "purchasefailed": "Kauf fehlgeschlagen, bitte erneut versuchen",
        "thanksforpurchase": "Danke für Ihren Kauf!",
        "loading...": "Lädt...",
        "getaccess": "Zugang zu allen erweiterten Einheiten mit einem einmaligen Kauf",
        "fluid": "Flüssigkeit",
        "electricity": "Elektrizität",
        "magnetism": "Magnetismus",
        "monetaryunits": "Währungseinheiten",
        "commonunits": "Allgemeine Einheiten",
        "searchunits": "Einheiten suchen",
        "units": "Einheiten",
        "from": "Von",
        "to": "bis",
        "value": "Wert",
        "speed": "Geschwindigkeit",
        "addedtofavorites": "Zu Favoriten hinzugefügt",
        "removed": "Entfernt",
        "source": "Quelle: Europäische Zentralbank (Frankfurter)",
        "source2": "Quelle: CoinGecko",
        "invalidinput": "Ungültiger Wert",
        "radiation": "Strahlung",
        "light": "Beleuchtung",

        "unit_speed": "Geschwindigkeit",
        "unit_weight": "Gewicht",
        "unit_length": "Länge",
        "unit_time": "Zeit",
        "unit_temperature": "Temperatur",
        "unit_volume": "Volumen",
        "unit_shoe_size": "Schuhgröße",
        "unit_data_size": "Datenmenge",
        "unit_data_transfer_speed": "Datenübertragungsrate",
        "unit_pressure": "Druck",
        "unit_power": "Leistung",
        "unit_torque": "Drehmoment",
        "unit_currency": "Währung",
        "unit_area": "Fläche",
        "unit_crypto_beta": "Krypto (Beta)",
        "unit_energy": "Energie",
        "unit_shares": "Verhältnis / Proportion",
        "unit_viscosity_dynamic": "Dynamische Viskosität",
        "unit_viscosity_kinematic": "Kinematische Viskosität",
        "unit_angles": "Winkel",
        "unit_electric_current": "Elektrischer Strom",
        "unit_electric_resistance": "Elektrischer Widerstand",
        "unit_numeral_system": "Zahlensystem",
        "unit_magnetomotive_force": "Magnetomotorische Kraft",
        "unit_magnetic_field_strength": "Magnetfeldstärke",
        "unit_magnetic_flux": "Magnetischer Fluss",
        "unit_image_resolution": "Bildauflösung",
        "unit_inductance": "Induktivität",
        "unit_charge": "Ladung",
        "unit_linear_charge": "Lineare Ladungsdichte",
        "unit_volume_charge": "Volumenladungsdichte",
        "unit_surface_charge": "Oberflächenladungsdichte",
        "unit_magnetic_flux_density": "Magnetische Flussdichte",
        "unit_radiation": "Strahlung",
        "unit_radiation_activity": "Aktivität der Strahlung",
        "unit_radiation_exposure": "Strahlenexposition",
        "unit_radiation_absorbed": "Strahlung – Absorbierte Dosis",
        "unit_linear_current": "Lineare Stromdichte",
        "unit_surface_tension": "Oberflächenspannung",
        "unit_flow_rate": "Durchflussrate",
        "unit_concentration_solution": "Konzentration (Lösung)",
        "unit_mass_flux_density": "Massenflussdichte",
        "unit_luminance": "Leuchtdichte",
        "unit_luminous_intensity": "Lichtstärke",
        "unit_luminous_flux": "Lichtstrom",
        "unit_illuminance": "Beleuchtungsstärke",
        "unit_frequency": "Frequenz",
        "unit_fuel_consumption": "Kraftstoffverbrauch",
    ]
    
    private let es: [String: String] = [
        "settings": "Configuración",
        "otherapps": "Otras apps",
        "univertfeedback": "Comentarios de Univert",
        "givefeedback": "Dar comentarios",
        "checkoutunivert": "¡Mira la app Univert!",
        "sharetheapp": "Compartir app",
        "ratetheapp": "Calificar app",
        "about": "Acerca de",
        "processing...": "Procesando...",
        "purchasecouldntrestore": "No se pudieron restaurar las compras",
        "restorefailed": "Error al restaurar",
        "purchaserestored": "Tu compra ha sido restaurada",
        "restorepurchase": "Restaurar compra",
        "advancedunitsunlocked": "Unidades avanzadas desbloqueadas",
        "unlockadvancedunits": "Univert PRO",
        "advancedunits": "Unidades avanzadas",
        "cancel": "Cancelar",
        "favoritescleared": "Favoritos eliminados",
        "clear": "Limpiar",
        "clearfavorites?": "¿Deseas eliminar tus favoritos guardados?",
        "clearfavorites": "Eliminar favoritos",
        "favorites": "Favoritos",
        "comma": "Separador decimal con coma",
        "darkmode": "Modo oscuro",
        "appearance": "Apariencia",
        "notaddedfavorites": "Aún no has añadido favoritos",
        "purchasefailed": "La compra ha fallado, inténtalo de nuevo",
        "thanksforpurchase": "¡Gracias por tu compra!",
        "loading...": "Cargando...",
        "getaccess": "Accede a todas las unidades avanzadas con una compra única",
        "fluid": "Fluido",
        "electricity": "Electricidad",
        "magnetism": "Magnetismo",
        "monetaryunits": "Unidades monetarias",
        "commonunits": "Unidades comunes",
        "searchunits": "Buscar unidades",
        "units": "Unidades",
        "from": "De",
        "to": "a",
        "value": "Valor",
        "speed": "Velocidad",
        "addedtofavorites": "Agregado a favoritos",
        "removed": "Eliminado",
        "source": "Fuente: Banco Central Europeo (Frankfurter)",
        "source2": "Fuente: CoinGecko",
        "invalidinput": "Valor inválido",
        "radiation": "Radiación",
        "light": "Iluminación",

        "unit_speed": "Velocidad",
        "unit_weight": "Peso",
        "unit_length": "Longitud",
        "unit_time": "Tiempo",
        "unit_temperature": "Temperatura",
        "unit_volume": "Volumen",
        "unit_shoe_size": "Talla de zapato",
        "unit_data_size": "Tamaño de datos",
        "unit_data_transfer_speed": "Velocidad de transferencia de datos",
        "unit_pressure": "Presión",
        "unit_power": "Potencia",
        "unit_torque": "Par",
        "unit_currency": "Moneda",
        "unit_area": "Área",
        "unit_crypto_beta": "Cripto (beta)",
        "unit_energy": "Energía",
        "unit_shares": "Relación / Proporción",
        "unit_viscosity_dynamic": "Viscosidad dinámica",
        "unit_viscosity_kinematic": "Viscosidad cinemática",
        "unit_angles": "Ángulos",
        "unit_electric_current": "Corriente eléctrica",
        "unit_electric_resistance": "Resistencia eléctrica",
        "unit_numeral_system": "Sistema numérico",
        "unit_magnetomotive_force": "Fuerza magnetomotriz",
        "unit_magnetic_field_strength": "Intensidad de campo magnético",
        "unit_magnetic_flux": "Flujo magnético",
        "unit_image_resolution": "Resolución de imagen",
        "unit_inductance": "Inductancia",
        "unit_charge": "Carga",
        "unit_linear_charge": "Densidad lineal de carga",
        "unit_volume_charge": "Densidad de carga volumétrica",
        "unit_surface_charge": "Densidad de carga superficial",
        "unit_magnetic_flux_density": "Densidad de flujo magnético",
        "unit_radiation": "Radiación",
        "unit_radiation_activity": "Actividad radiactiva",
        "unit_radiation_exposure": "Exposición a la radiación",
        "unit_radiation_absorbed": "Radiación – Dosis absorbida",
        "unit_linear_current": "Densidad de corriente lineal",
        "unit_surface_tension": "Tensión superficial",
        "unit_flow_rate": "Caudal",
        "unit_concentration_solution": "Concentración (solución)",
        "unit_mass_flux_density": "Densidad de flujo de masa",
        "unit_luminance": "Luminancia",
        "unit_luminous_intensity": "Intensidad luminosa",
        "unit_luminous_flux": "Flujo luminoso",
        "unit_illuminance": "Iluminancia",
        "unit_frequency": "Frecuencia",
        "unit_fuel_consumption": "Consumo de combustible",
    ]
    
    private let fr: [String: String] = [
        "settings": "Paramètres",
        "otherapps": "Autres applications",
        "univertfeedback": "Retour Univert",
        "givefeedback": "Donner un retour",
        "checkoutunivert": "Découvrez l’app Univert !",
        "sharetheapp": "Partager l’application",
        "ratetheapp": "Noter l’application",
        "about": "À propos",
        "processing...": "Traitement...",
        "purchasecouldntrestore": "Impossible de restaurer les achats",
        "restorefailed": "Échec de la restauration",
        "purchaserestored": "Votre achat a été restauré",
        "restorepurchase": "Restaurer l’achat",
        "advancedunitsunlocked": "Unités avancées déverrouillées",
        "unlockadvancedunits": "Univert PRO",
        "advancedunits": "Unités avancées",
        "cancel": "Annuler",
        "favoritescleared": "Favoris effacés",
        "clear": "Effacer",
        "clearfavorites?": "Souhaitez-vous effacer vos favoris enregistrés ?",
        "clearfavorites": "Effacer les favoris",
        "favorites": "Favoris",
        "comma": "Séparateur décimal virgule",
        "darkmode": "Mode sombre",
        "appearance": "Apparence",
        "notaddedfavorites": "Vous n’avez encore ajouté aucun favori",
        "purchasefailed": "Échec de l’achat, veuillez réessayer",
        "thanksforpurchase": "Merci pour votre achat !",
        "loading...": "Chargement...",
        "getaccess": "Accédez à toutes les unités avancées avec un achat unique",
        "fluid": "Fluide",
        "electricity": "Électricité",
        "magnetism": "Magnétisme",
        "monetaryunits": "Unités monétaires",
        "commonunits": "Unités courantes",
        "searchunits": "Rechercher des unités",
        "units": "Unités",
        "from": "De",
        "to": "à",
        "value": "Valeur",
        "speed": "Vitesse",
        "addedtofavorites": "Ajouté aux favoris",
        "removed": "Supprimé",
        "source": "Source : Banque centrale européenne (Frankfurter)",
        "source2": "Source : CoinGecko",
        "invalidinput": "Valeur invalide",
        "radiation": "Rayonnement",
        "light": "Éclairage",

        "unit_speed": "Vitesse",
        "unit_weight": "Poids",
        "unit_length": "Longueur",
        "unit_time": "Temps",
        "unit_temperature": "Température",
        "unit_volume": "Volume",
        "unit_shoe_size": "Pointure",
        "unit_data_size": "Taille des données",
        "unit_data_transfer_speed": "Vitesse de transfert de données",
        "unit_pressure": "Pression",
        "unit_power": "Puissance",
        "unit_torque": "Couple",
        "unit_currency": "Devise",
        "unit_area": "Surface",
        "unit_crypto_beta": "Crypto (bêta)",
        "unit_energy": "Énergie",
        "unit_shares": "Rapport / Proportion",
        "unit_viscosity_dynamic": "Viscosité dynamique",
        "unit_viscosity_kinematic": "Viscosité cinématique",
        "unit_angles": "Angles",
        "unit_electric_current": "Courant électrique",
        "unit_electric_resistance": "Résistance électrique",
        "unit_numeral_system": "Système numérique",
        "unit_magnetomotive_force": "Force magnétomotrice",
        "unit_magnetic_field_strength": "Intensité du champ magnétique",
        "unit_magnetic_flux": "Flux magnétique",
        "unit_image_resolution": "Résolution d’image",
        "unit_inductance": "Inductance",
        "unit_charge": "Charge",
        "unit_linear_charge": "Densité linéique de charge",
        "unit_volume_charge": "Densité volumique de charge",
        "unit_surface_charge": "Densité surfacique de charge",
        "unit_magnetic_flux_density": "Densité de flux magnétique",
        "unit_radiation": "Rayonnement",
        "unit_radiation_activity": "Activité radioactive",
        "unit_radiation_exposure": "Exposition aux radiations",
        "unit_radiation_absorbed": "Rayonnement – Dose absorbée",
        "unit_linear_current": "Densité de courant linéaire",
        "unit_surface_tension": "Tension superficielle",
        "unit_flow_rate": "Débit",
        "unit_concentration_solution": "Concentration (solution)",
        "unit_mass_flux_density": "Densité de flux de masse",
        "unit_luminance": "Luminance",
        "unit_luminous_intensity": "Intensité lumineuse",
        "unit_luminous_flux": "Flux lumineux",
        "unit_illuminance": "Éclairement",
        "unit_frequency": "Fréquence",
        "unit_fuel_consumption": "Consommation de carburant",
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
