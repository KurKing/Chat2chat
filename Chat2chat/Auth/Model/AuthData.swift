//
//  AuthData.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import Foundation

struct AuthData {
    let email: String
    let password: String
    
    var isValid: Bool {
        return email ~= Constants.Regex.email && password ~= Constants.Regex.password
    }
    
    var validationFirebaseError: FirebaseCustomError? {
        if !(email ~= Constants.Regex.email) {
            return .nonValidEmail
        }
        if !(password ~= Constants.Regex.password) {
            return .nonValidPassword
        }
        return nil
    }
}
