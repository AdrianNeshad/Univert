//
//  PurchaseView.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-15.
//

import SwiftUI

struct PurchaseView: View {
    @ObservedObject var storeManager: StoreManager
    @Binding var isUnlocked: Bool
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("isDarkMode") private var isDarkMode = true

    
    @available(iOS 16.0, *)
    var body: some View {
        VStack(spacing: 20) {
            Text(StringManager.shared.get("unlockadvancedunits"))
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .padding(.top, 20)
            
            Text(StringManager.shared.get("getaccess"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let product = storeManager.products.first {
                Button(action: { storeManager.purchaseProduct(product: product) }) {
                    Text("\(product.localizedPrice)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            } else {
                ProgressView(StringManager.shared.get("loading..."))
            }
            
            if storeManager.transactionState == .purchased || isUnlocked {
                Text(StringManager.shared.get("thanksforpurchase"))
                    .foregroundColor(.green)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
            
            if storeManager.transactionState == .failed {
                Text(StringManager.shared.get("purchasefailed"))
                    .foregroundColor(.red)
            }
            
            Button(StringManager.shared.get("cancel")) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
