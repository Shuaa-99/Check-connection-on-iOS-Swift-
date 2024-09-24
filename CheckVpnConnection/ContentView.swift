//
//  ContentView.swift
//  CheckVpnConnection
//
//  Created by SHUAA on 25.9.2024.
//

import SwiftUI
import Network
struct ContentView: View {
    @StateObject private var vpnViewModel = VpnViewModel()

    var body: some View {
        VStack {
            Text(vpnViewModel.isVpnActive ? "VPN نشط" : "VPN غير نشط")
                .font(.largeTitle)
                .padding()
            
            Button("تحقق من حالة VPN") {
                vpnViewModel.checkVpnStatus()
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $vpnViewModel.showAlert) {
            Alert(
                title: Text("خطأ"),
                message: Text(vpnViewModel.errorMessage),
                dismissButton: .default(Text("حسناً")) {
                    exit(0) // اغلاق التطبيق
                }
            )
        }
        .onAppear {
            // تحقق من حالة VPN عند ظهور الواجهة
            vpnViewModel.checkVpnStatus()
        }
    }
}
#Preview {
    ContentView()
}


// تعريف VpnChecker
struct VpnChecker {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isVpnActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
              let allKeys = keys.allKeys as? [String] else { return false }

        // التحقق من بروتوكولات الأنفاق
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}

// تعريف VpnViewModel
class VpnViewModel: ObservableObject {
    @Published var isVpnActive: Bool = false
    @Published var showAlert: Bool = false
    let errorMessage: String = "يوجد اتصال VPN، سيتم إغلاق التطبيق."

    init() {
        checkVpnStatus()
    }

    func checkVpnStatus() {
        isVpnActive = VpnChecker.isVpnActive()
        if isVpnActive {
            showAlert = true
        }
    }
}


