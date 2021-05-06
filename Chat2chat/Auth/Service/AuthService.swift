//
//  AuthService.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import Foundation
import Firebase

class AuthService {
    
    func login(authData: AuthData, successComplition: @escaping ()->(), failComplition: @escaping (FirebaseCustomError)->()) {
        
        if !isValidated(authData: authData) {
            failComplition(.incorrectPassword)
            return
        }
        
        Auth.auth().signIn(withEmail: authData.email.lowercased(), password: authData.password) { [weak self] (result, error) in
            
            if result != nil {
                self?.saveAuthDataToStorage(authData: authData)
                successComplition()
                return
            }
            
            failComplition(FirebaseCustomError.mapFromFirebaseError(error: error))
        }
    }
    
    func signUp(name: String, authData: AuthData, successComplition: @escaping ()->(), failComplition: @escaping ()->()) {
        Auth.auth().createUser(withEmail: authData.email.lowercased(), password: authData.password) { [weak self] (result, error) in
            if let result = result, let strongSelf = self {
                strongSelf.createUser(result: result, name: name)
                successComplition()
            } else {
                failComplition()
            }
        }
    }
    
    private func createUser(result: AuthDataResult, name: String) {
        result.user.getIDToken { (token, error) in
            if let token = token {
                Firestore.firestore()
                    .collection(Constants.DataBase.userCollection)
                    .document(token)
                    .setData(["name":name])
            }
        }
    }
    
    //MARK: - UserDefaults
    func getAuthDataFromStorage() -> AuthData? {
        let validator = Validator()
        
        guard let email = validator.validate(
                string: UserDefaults.standard
                    .string(forKey: Constants.UserDefaultsKey.email)
        ) else {
            return nil
        }
        
        guard let password = validator.validate(
                string: UserDefaults.standard
                    .string(forKey: Constants.UserDefaultsKey.password)
        ) else {
            return nil
        }
        
        return AuthData(email: email, password: password)
    }
    
    private func saveAuthDataToStorage(authData: AuthData) {
        UserDefaults.standard.setValue(authData.email, forKey: Constants.UserDefaultsKey.email)
        UserDefaults.standard.setValue(authData.password, forKey: Constants.UserDefaultsKey.password)
    }
    
    //MARK: - Validation
    private func isValidated(authData: AuthData) -> Bool {
        return authData.email ~= Constants.Regex.email && authData.password ~= Constants.Regex.password
    }
    private func getValidationErrorMessages(authData: AuthData) -> String? {
        if !(authData.email ~= Constants.Regex.email) {
            return FirebaseCustomError.nonValidEmail.rawValue
        }
        if !(authData.password ~= Constants.Regex.password) {
            return FirebaseCustomError.nonValidPassword.rawValue
        }
        return nil
    }
}
