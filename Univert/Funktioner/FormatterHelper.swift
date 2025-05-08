//
//  FormatterHelper.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-08.
//

import Foundation

class FormatterHelper {
    static let shared = FormatterHelper()
    
    private let numberFormatter: NumberFormatter
    
    private init() {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.numberStyle = .decimal
        
        formatter.decimalSeparator = ","              // decimaltecken
        formatter.groupingSeparator = " "             // mellanrum istället för komma
        formatter.usesGroupingSeparator = true        // aktivera tusentalsavgränsare
        
        self.numberFormatter = formatter
    }
    
    func formatResult(_ value: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

