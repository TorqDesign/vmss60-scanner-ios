//
//  QRScannerView.swift
//  VMSS60Scanner-SwiftUI
//
//  Created by James Xu on 2020-03-22.
//  Copyright © 2020 James Xu. All rights reserved.
//

import SwiftUI
import CodeScanner

struct QRScannerView: View {
    @State private var showingAlert = false
    @State var pushActive = false
    @State var reset = false
    @State var user: UserData = UserData(firstName: "", lastName: "", type: "", id: "")
    var event: Event
    var body: some View {
        VStack {
            NavigationLink(destination: UserView(user: self.user), isActive: self.$pushActive) {
              Text("")
            }.hidden()
            NavigationLink(destination: QRScannerView(event: self.event), isActive: self.$reset) {
              Text("")
            }.hidden()
            CodeScannerView(codeTypes: [.qr], simulatedData: "eyJmaXJzdE5hbWUiOiAiamFtZXMiLCAibGFzdE5hbWUiOiAieHUiLCAidHlwZSI6ICJtYWluLWV2ZW50IiwgImlkIjoiYWdzajEyMyJ9") { result in
                switch result {
                case .success(let code):
                    do {
                        let user: UserData = try getUserStructFromB64(b64String: code)
                        print("Found user: \(user.firstName)")
                        self.user = user
                        self.pushActive = true
                    } catch {
                        self.showingAlert = true
                        self.reset = true
                        print("Unexpected error: \(error).")
                    }
                    print("Found code: \(code)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct QRScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerView(event: Event(name: "Friday Night"))
    }
}
