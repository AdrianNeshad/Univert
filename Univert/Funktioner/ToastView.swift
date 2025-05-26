//
//  ToastView.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-26.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(.horizontal, 40)
    }
}
