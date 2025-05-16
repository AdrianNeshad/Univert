//
//  StoreManager.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-15.
//

import Foundation
import StoreKit

class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    @Published var products: [SKProduct] = []
    @Published var transactionState: SKPaymentTransactionState?
    
    func getProducts(productIDs: [String]) {
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
        }
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            SKPaymentQueue.default().add(self)
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "advancedUnitsUnlocked")
                    self.transactionState = transaction.transactionState
                }
                queue.finishTransaction(transaction)
            case .failed:
                self.transactionState = .failed
                queue.finishTransaction(transaction)
            default:
                break
            }
        }
    }
}

// Hjälpfunktion för att visa pris i lokal valuta
extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price) ?? "\(price)"
    }
}
