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
            TextField("Value", text: $inputValue)
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
                            .font(.title)
                            .bold()
                            .frame(width: 100)
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
                            .font(.title)
                            .bold()
                            .frame(width: 100)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 300) // Justera höjd för hjulet om du vill

            Text("Converting \(selectedFromUnit ?? "") to \(selectedToUnit ?? "")")
                .padding(.top, 20)

            Spacer()
        }
        .navigationTitle("Velocity")
        .padding()
    }
}
