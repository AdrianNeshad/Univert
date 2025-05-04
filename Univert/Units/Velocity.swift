//
//  Velocity.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Velocity: View {
    @State private var selectedFromUnit: String? = "m/s"
    @State private var selectedToUnit: String? = "km/h"
    @State private var inputValue = ""

    let units = ["m/s", "km/h", "mph", "knots"]

    var body: some View {
        VStack {
            // TextField för att skriva in värde
            TextField("Skriv in värde", text: $inputValue)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                VStack {
                    Text("From")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    PomodoroPicker(
                        selection: $selectedFromUnit,
                        options: units
                    ) { unit in
                        Text(unit)
                            .font(.headline)
                            .frame(width: 60) // Anpassa bredd om du vill
                    }
                }
                .frame(maxWidth: .infinity)

                VStack {
                    Text("To")
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    PomodoroPicker(
                        selection: $selectedToUnit,
                        options: units
                    ) { unit in
                        Text(unit)
                            .font(.headline)
                            .frame(width: 60)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 150) // Justera höjd för hjulet om du vill

            // Visar vad du valt + input
            Text("Konverterar \(inputValue) \(selectedFromUnit ?? "") till \(selectedToUnit ?? "")")
                .padding(.top, 20)

            Spacer()
        }
        .navigationTitle("Velocity")
        .padding()
    }
}
