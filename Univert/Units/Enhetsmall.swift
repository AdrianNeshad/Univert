//
//  Enhetsmall.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-05.
//

import SwiftUI

struct Enhetsmall: View {
    @State private var selectedFromUnit: String? = "XXX"
    @State private var selectedToUnit: String? = "XXX"
    @State private var inputValue = ""
    @State private var outputValue = ""
    
    let units = ["XXX", "XXX", "XXX"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Från")
                    .font(.title)
                    .bold()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                
                Text("➤")
                    .font(.title)
                    .bold()
                    .frame(width: 100)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)

                Text("Till")
                    .font(.title)
                    .bold()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
            } //HStack
            
            HStack {
                Text("►")
                    .font(.title)
                    .frame(width: 50)
                PomodoroPicker(
                    selection: $selectedFromUnit,
                    options: units
                ) { unit in
                    Text(unit)
                        .font(.title)
                        .bold()
                        .frame(width: 100)
                        .padding(.leading, -90)
                }
                PomodoroPicker(
                    selection: $selectedToUnit,
                    options: units
                ) { unit in
                    Text(unit)
                        .font(.title)
                        .bold()
                        .frame(width: 100)
                        .padding(.trailing, -90)
                }
                Text("◄")
                    .font(.title)
                    .frame(width: 50)
            } //HStack
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            
            
            HStack {
                Text("(\(selectedFromUnit ?? ""))")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                
                Text("(\(selectedToUnit ?? ""))")
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 0)
            } //HStack
            
            HStack(spacing: 10) { // Justera spacing mellan rutorna
                TextField("Värde", text: $inputValue)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // Gör så att TextField tar upp lika mycket plats
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
                    
                Text(outputValue.isEmpty ? "" : outputValue)
                    .padding(10)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity) // Gör så att Text tar upp lika mycket plats
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.leading)
            } //HStack
            .padding([.leading, .trailing], 10)
        } //VStack
        .padding(.top, 20)
        Spacer()
        .navigationTitle("Enhetsmall")
        .padding()

    }
}
