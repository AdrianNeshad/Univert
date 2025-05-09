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
        
        // Ta bort dessa ↓ så vi sätter dem dynamiskt istället:
        // formatter.decimalSeparator = ","
        formatter.groupingSeparator = " "
        formatter.usesGroupingSeparator = true
        
        self.numberFormatter = formatter
    }
    
    func formatResult(_ value: Double, useSwedishDecimal: Bool, maximumFractionDigits: Int) -> String {
        numberFormatter.decimalSeparator = useSwedishDecimal ? "," : "."
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }

}


