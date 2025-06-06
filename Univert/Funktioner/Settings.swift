//
//  Settings.swift
//  Univert
//
//  Created by Adrian Neshad on 2025-05-09.
//

import SwiftUI
import StoreKit
import MessageUI
import AlertToast

struct Inställningar: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    @AppStorage("useSwedishDecimal") private var useSwedishDecimal = true
    @AppStorage("appLanguage") private var appLanguage = "en"
    @AppStorage("advancedUnitsUnlocked") private var advancedUnitsUnlocked = false
    @StateObject private var storeManager = StoreManager()
    @State private var showRestoreAlert = false
    @State private var showPurchaseSheet = false
    @State private var restoreStatus: RestoreStatus?
    @Environment(\.requestReview) var requestReview
    @State private var showMailFeedback = false
    @State private var mailErrorAlert = false
    @State private var units: [Units] = []
    @State private var showClearAlert = false
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var showShareSheet = false
    
    enum RestoreStatus {
        case success, failure
    }

    var body: some View {
        Form {
            Section(header: Text(StringManager.shared.get("appearance"))) {
                Toggle(StringManager.shared.get("darkmode"), isOn: $isDarkMode)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                Picker("Språk / Language", selection: $appLanguage) {
                    Text("English").tag("en")
                    Text("Svenska").tag("sv")
                    Text("Deutsch").tag("de")
                    Text("Español").tag("es")
                    Text("Français").tag("fr")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: appLanguage) { newLang in
                    if newLang == "en" {
                        useSwedishDecimal = false
                    } else {
                        useSwedishDecimal = true
                    }
                }
                Toggle(StringManager.shared.get("comma"),
                       isOn: $useSwedishDecimal)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .disabled(true)
            }
            Section(header: Text(StringManager.shared.get("favorites"))) {
                Button(action: {
                    showClearAlert = true
                }) {
                    Text(StringManager.shared.get("clearfavorites"))
                        .foregroundColor(.red)
                }
                .confirmationDialog(
                    StringManager.shared.get("clearfavorites?"),
                    isPresented: $showClearAlert,
                    titleVisibility: .visible
                ) {
                    Button(StringManager.shared.get("clear"), role: .destructive) {
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "savedUnits")
                        defaults.synchronize()
                        
                        units = Units.preview()
                        
                        toastMessage = StringManager.shared.get("favoritescleared")
                            withAnimation {
                                showToast = true
                            }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                    }
                    Button(StringManager.shared.get("cancel"), role: .cancel) { }
                }
            }
            // Köp-sektion
            Section(header: Text(StringManager.shared.get("advancedunits"))) {
                if !advancedUnitsUnlocked {
                    Button(action: {
                        showPurchaseSheet = true
                    }) {
                        HStack {
                            Image(systemName: "lock.open")
                            Text(StringManager.shared.get("unlockadvancedunits"))
                            Spacer()
                            if let product = storeManager.products.first {
                                Text(product.localizedPrice)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .sheet(isPresented: $showPurchaseSheet) {
                        PurchaseView(storeManager: storeManager, isUnlocked: $advancedUnitsUnlocked)
                    }
                } else {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                        Text(StringManager.shared.get("advancedunitsunlocked"))
                            .foregroundColor(.green)
                    }
                }
                
                Button(StringManager.shared.get("restorepurchase")) {
                    storeManager.restorePurchases()
                    showRestoreAlert = true
                }
                .alert(isPresented: $showRestoreAlert) {
                    switch restoreStatus {
                    case .success:
                        return Alert(
                            title: Text(StringManager.shared.get("purchaserestored")),
                            message: Text(StringManager.shared.get("purchaserestored")),
                            dismissButton: .default(Text("OK")))
                    case .failure:
                        return Alert(
                            title: Text(StringManager.shared.get("restorefailed")),
                            message: Text(StringManager.shared.get("purchasecouldntrestore")),
                            dismissButton: .default(Text("OK")))
                    default:
                        return Alert(
                            title: Text(StringManager.shared.get("processing...")),
                            message: nil,
                            dismissButton: .cancel())
                    }
                }
                .onReceive(storeManager.$transactionState) { state in
                    if state == .restored {
                        restoreStatus = .success
                        advancedUnitsUnlocked = true
                    } else if state == .failed {
                        restoreStatus = .failure
                    }
                }
            }
            Section(header: Text(StringManager.shared.get("about"))) {
                Button(StringManager.shared.get("ratetheapp")) {
                    requestReview()
                }
                Button(StringManager.shared.get("sharetheapp")) {
                                   showShareSheet = true
                               }
                               .sheet(isPresented: $showShareSheet) {
                                   let message = StringManager.shared.get("checkoutunivert")
                                   let appLink = URL(string: "https://apps.apple.com/us/app/univert/id6745692591")!
                                   ShareSheet(activityItems: [message, appLink])
                                       .presentationDetents([.medium])
                               }
                Button(StringManager.shared.get("givefeedback")) {
                    if MFMailComposeViewController.canSendMail() {
                        showMailFeedback = true
                    } else {
                        mailErrorAlert = true
                    }
                }
                .sheet(isPresented: $showMailFeedback) {
                    MailFeedback(isShowing: $showMailFeedback,
                                 recipientEmail: "Adrian.neshad1@gmail.com",
                                 subject: StringManager.shared.get("univertfeedback"),
                                 messageBody: "")
                }
            }   
            /*
            Section(header: Text(StringManager.shared.get("otherapps")) {
                Link(destination: URL(string: "https://apps.apple.com/us/app/unifeed/id6746576849")!) {
                    HStack {
                        Image("Unifeed")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(8)
                        Text("Unifeed")
                    }
                }
                Link(destination: URL(string: "https://apps.apple.com/us/app/flixswipe/id6746682499")!) {
                    HStack {
                        Image("flixswipe")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(8)
                        Text("FlixSwipe")
                    }
                }
            }
            */
            Section {
                EmptyView()
            } footer: {
                VStack(spacing: 4) {
                    Text(appVersion)
                    Text("© 2025 Univert App")
                    Text("Github.com/AdrianNeshad")
                    Text("Linkedin.com/in/adrian-neshad")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, -100)
            }
        }
        .navigationTitle(StringManager.shared.get("settings"))
        .onAppear {
            storeManager.getProducts(productIDs: ["Univert.AdvancedUnits"])
        }
        .toast(isPresenting: $showToast) {
                    AlertToast(type: .complete(Color.green), title: toastMessage)
                }
    }
    
    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?"
        return "Version \(version) (\(build))"
    }
}
