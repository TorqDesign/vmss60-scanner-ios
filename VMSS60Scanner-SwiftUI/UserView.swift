//
//  UserView.swift
//  VMSS60Scanner-SwiftUI
//
//  Created by James Xu on 2020-03-22.
//  Copyright © 2020 James Xu. All rights reserved.
//

import SwiftUI
import Alamofire

struct UserView: View {
    @State private var showingAlert = false
    @State private var alertMsg = ""
    @State private var alertTitle = ""
    var user: UserData
    var body: some View {
        VStack {
            Text(user.firstName)
            Text(user.lastName)
            Text(user.type)
            Button(action: {
                print("hiii")
                AF.request(API_BASE + "/ticket/\(self.user.id)", method: .post).validate().response { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        self.alertTitle = "User checked-in"
                        self.alertMsg = "You have succesfully checked in this user"
                        self.showingAlert = true
                    case let .failure(error):
                        print(error)
                        self.alertTitle = "There was an error"
                        self.alertMsg = "\(error)"
                        self.showingAlert = true
                    }
                }
                
            }) {
                Text("Check-In User")
                    .fontWeight(.bold)
                .font(.subheadline)
                .padding()
                    .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(40)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMsg), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: UserData(firstName: "James", lastName: "Xu", type: "main", id: "hello"))
    }
}
