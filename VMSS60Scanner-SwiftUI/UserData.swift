//
//  UserData.swift
//  VMSS60Scanner-SwiftUI
//
//  Created by James Xu on 2020-03-22.
//  Copyright © 2020 James Xu. All rights reserved.
//

import Foundation
import Alamofire

let API_BASE = "http://192.168.0.50:3005"

/// UserData structure
struct UserData: Decodable {
    let firstName: String
    let lastName: String
    let type: String
    let id: String
}

enum UserDataInitError: Error {
    case invalidB64
    case invalidJSON
}

/// Converts a B64 JSON of a UserData into a UserData Struct
/// - Parameter b64String: B64 encoded string to convert to a Struct
func getUserStructFromB64(b64String: String) throws -> UserData {
    guard let decodedData = Data(base64Encoded: b64String) else { throw UserDataInitError.invalidB64 }
    let decodedString = String(data: decodedData, encoding: .utf8)
    if (decodedString != nil) {
        guard let jsonData = decodedString!.data(using: .utf8) else { throw UserDataInitError.invalidB64 }
        do {
            let userData: UserData = try JSONDecoder().decode(UserData.self, from: jsonData)
            return userData
        } catch {
            debugPrint(error)
            throw UserDataInitError.invalidJSON
        }
    }
    throw UserDataInitError.invalidB64
}

