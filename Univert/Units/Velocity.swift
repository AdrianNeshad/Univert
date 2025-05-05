//
//  Velocity.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-04.
//

import SwiftUI

struct Velocitet: View {
    @State private var selectedFromUnit: String? = "m/s"
    @State private var selectedToUnit: String? = "m/s"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    
    let units = ["m/s", "km/h", "mph", "knots"]
    
    var body: some View {
        VStack {
                HStack {
                    VStack {
                        Text("Från")
                            .font(.title)
                            .bold()
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(15)
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                            .multilineTextAlignment(.center)
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
                    
                    Text("🔀")
                                .font(.title)
                                .frame(width: 50)
                    
                    VStack {
                        Text("Till")
                            .font(.title)
                            .bold()
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(15)
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                            .multilineTextAlignment(.center)
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
                .frame(height: 280) // Justera höjd för hjulet
                
                VStack(spacing: 2) { // Justera spacing mellan Text och TextField
                    Text("(\(selectedFromUnit ?? ""))")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    TextField("Värde", text: $inputValue)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.leading, 10)
                        .frame(height: 50)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        .padding([.leading, .trailing], 10)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                    
                    Text("(\(selectedToUnit ?? ""))")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                    
                    Text(outputValue.isEmpty ? "" : outputValue)
                        .padding(.leading, 10)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        .padding([.leading, .trailing], 10)
                        .multilineTextAlignment(.leading)
                }
                
            }
            .navigationTitle("Velocitet")
            .padding()
        }
    }
