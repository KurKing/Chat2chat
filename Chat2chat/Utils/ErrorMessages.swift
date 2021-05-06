//
//  ErrorMessages.swift
//  Chat2chat
//
//  Created by Oleksiy on 06.05.2021.
//

import Foundation
import FirebaseAuth

enum FirebaseCustomError: String {
    case nonValidPassword = "Password should contain minimum eight characters, at least one uppercase letter, one lowercase letter and one number"
    case nonValidEmail = "Enter valid email"
    
    case incorrectPassword = "Sorry, your username or password is incorrect."
    case unknownError = "Oops! Something went wrong."
    case accountExistsWithDifferentCredential = "You have already sign up."
    case userNotFound = "You naven`t sign up yet"
    
    case networkError = "Please connect to the internet"
    
    static func mapFromFirebaseError(error: Error?) -> FirebaseCustomError {
        guard let error = error else {
            return .unknownError
        }
        guard let errorCode = AuthErrorCode(rawValue: error._code) else {
            return .unknownError
        }

        switch errorCode {
        case .accountExistsWithDifferentCredential:
            return .accountExistsWithDifferentCredential
        case .wrongPassword:
            return .incorrectPassword
        case .invalidEmail:
            return .nonValidEmail
        case .networkError:
            return .networkError
        case .webNetworkRequestFailed:
            return .networkError
        case .userNotFound:
            return .userNotFound
        default:
            return .unknownError
        }
    }
}
