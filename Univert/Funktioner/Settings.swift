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
            // Inställningar för utseende
            Section(header: Text(appLanguage == "sv" ? "Utseende" : "Appearance")) {
                Toggle(appLanguage == "sv" ? "Mörkt läge" : "Dark mode", isOn: $isDarkMode)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                
                Picker("Språk / Language", selection: $appLanguage) {
                    Text("English").tag("en")
                    Text("Svenska").tag("sv")
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: appLanguage) { newLang in
                    if newLang == "sv" {
                        useSwedishDecimal = true
                    } else {
                        useSwedishDecimal = false
                    }
                }
                
                Toggle(appLanguage == "sv" ? "Komma decimalseparator" : "Comma decimal separator",
                       isOn: $useSwedishDecimal)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .disabled(true)
            }
            
            // rensa favoriter
            Section(header: Text(appLanguage == "sv" ? "Favoriter" : "Favorites")) {
                Button(action: {
                    showClearAlert = true
                }) {
                    Text(appLanguage == "sv" ? "Rensa favoriter" : "Clear Favorites")
                        .foregroundColor(.red)
                }
                .confirmationDialog(
                    appLanguage == "sv" ? "Vill du rensa dina sparade favoriter?" : "Do you want to clear your saved favorites?",
                    isPresented: $showClearAlert,
                    titleVisibility: .visible
                ) {
                    Button(appLanguage == "sv" ? "Rensa" : "Clear", role: .destructive) {
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "savedUnits")
                        defaults.synchronize()
                        
                        units = Units.preview()
                        
                        toastMessage = appLanguage == "sv" ? "Favoriter rensade" : "Favorites Cleared"
                            withAnimation {
                                showToast = true
                            }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                    }
                    Button(appLanguage == "sv" ? "Avbryt" : "Cancel", role: .cancel) { }
                }
            }

            // Köp-sektion
            Section(header: Text(appLanguage == "sv" ? "Avancerade enheter" : "Advanced Units")) {
                if !advancedUnitsUnlocked {
                    Button(action: {
                        showPurchaseSheet = true
                    }) {
                        HStack {
                            Image(systemName: "lock.open")
                            Text(appLanguage == "sv" ? "Lås upp avancerade enheter" : "Unlock Advanced Units")
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
                        Text(appLanguage == "sv" ? "Avancerade enheter upplåsta" : "Advanced Units Unlocked")
                            .foregroundColor(.green)
                    }
                }
                
                Button(appLanguage == "sv" ? "Återställ köp" : "Restore Purchases") {
                    storeManager.restorePurchases()
                    showRestoreAlert = true
                }
                .alert(isPresented: $showRestoreAlert) {
                    switch restoreStatus {
                    case .success:
                        return Alert(
                            title: Text(appLanguage == "sv" ? "Köp återställda" : "Purchases Restored"),
                            message: Text(appLanguage == "sv" ? "Dina köp har återställts." : "Your purchases have been restored."),
                            dismissButton: .default(Text("OK")))
                    case .failure:
                        return Alert(
                            title: Text(appLanguage == "sv" ? "Återställning misslyckades" : "Restore Failed"),
                            message: Text(appLanguage == "sv" ? "Inga köp kunde återställas." : "No purchases could be restored."),
                            dismissButton: .default(Text("OK")))
                    default:
                        return Alert(
                            title: Text(appLanguage == "sv" ? "Bearbetar..." : "Processing..."),
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
            
            Section(header: Text(appLanguage == "sv" ? "Om" : "About")) {
                Button(appLanguage == "sv" ? "Betygsätt appen" : "Rate the App") {
                    requestReview()
                }
                Button(appLanguage == "sv" ? "Dela appen" : "Share the App") {
                                   showShareSheet = true
                               }
                               .sheet(isPresented: $showShareSheet) {
                                   let message = appLanguage == "sv"
                                       ? "Kolla in nyhetsappen Unifeed! 📲"
                                       : "Check out the Unifeed news app! 📲"
                                   let appLink = URL(string: "https://apps.apple.com/us/app/univert/id6745692591")!
                                   ShareSheet(activityItems: [message, appLink])
                                       .presentationDetents([.medium])
                               }
                Button(appLanguage == "sv" ? "Ge feedback" : "Give Feedback") {
                    if MFMailComposeViewController.canSendMail() {
                        showMailFeedback = true
                    } else {
                        mailErrorAlert = true
                    }
                }
                .sheet(isPresented: $showMailFeedback) {
                    MailFeedback(isShowing: $showMailFeedback,
                                 recipientEmail: "Adrian.neshad1@gmail.com",
                                 subject: appLanguage == "sv" ? "Univert feedback" : "Univert Feedback",
                                 messageBody: "")
                }
            }            // App-info
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
        .navigationTitle(appLanguage == "sv" ? "Inställningar" : "Settings")
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
