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
    @State private var outputValue = ""


    let units = ["m/s", "km/h", "mph", "knots"]

    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("From")
                        .font(.title)
                        .bold()
                    Text("(\(selectedFromUnit ?? ""))")
                        .font(.system(size: 15))
                    PomodoroPicker(
                        selection: $selectedFromUnit,
                        options: units
                    ) { unit in
                        Text(unit)
                            .font(.title)
                            .bold()
                            .frame(width: 100)
                    }
                    TextField("Value", text: $inputValue)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(height: 50)
                        .frame(maxWidth: 100)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        .padding()
                }
                .frame(maxWidth: .infinity)

                VStack {
                    Text("To")
                        .font(.title)
                        .bold()
                    Text("(\(selectedToUnit ?? ""))")
                        .font(.system(size: 15))
                    PomodoroPicker(
                        selection: $selectedToUnit,
                        options: units
                    ) { unit in
                        Text(unit)
                            .font(.title)
                            .bold()
                            .frame(width: 100)
                    }
                    Text(outputValue.isEmpty ? "" : outputValue)
                                            .frame(height: 50)
                                            .frame(maxWidth: 100)
                                            .background(Color.gray.opacity(0.1))
                                            .cornerRadius(5)
                                            .padding()

                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 280) // Justera höjd för hjulet
            Spacer()
        }
        .navigationTitle("Velocity")
        .padding()
    }
}
