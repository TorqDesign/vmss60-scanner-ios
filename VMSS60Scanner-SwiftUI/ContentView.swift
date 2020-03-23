//
//  ContentView.swift
//  VMSS60Scanner-SwiftUI
//
//  Created by James Xu on 2020-03-22.
//  Copyright © 2020 James Xu. All rights reserved.
//

import SwiftUI
import CodeScanner

struct Event: Identifiable {
    var id = UUID()
    var name: String
}

let eventData: [Event] = [Event(name: "Friday Night"), Event(name: "Fashion Show"), Event(name: "Banquet")]

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(eventData) { event in
                NavigationLink(destination: QRScannerView(event: event)) {
                    Text(event.name)
                }.navigationBarTitle(Text("VMSS60"))
            }
        }
//        NavigationView {
//            VStack {
//                NavigationLink(destination: QRScannerView()) {
//                    Text("Scan QR Code")
//                }.navigationBarTitle(Text("VMSS60 Organizer"))
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
