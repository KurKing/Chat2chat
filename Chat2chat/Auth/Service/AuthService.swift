//
//  AuthService.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import Foundation
import Firebase

class AuthService {
    
    func login(authData: AuthData, successComplition: @escaping (String)->(), failComplition: @escaping (FirebaseCustomError)->()) {
        
        if !isValidated(authData: authData) {
            failComplition(.incorrectPassword)
            return
        }
        
        Auth.auth().signIn(withEmail: authData.email.lowercased(), password: authData.password) { [weak self] (result, error) in
            
            if let result = result {
                self?.saveAuthDataToStorage(authData: authData)
                guard let email = result.user.email else {
                    failComplition(FirebaseCustomError.unknownError)
                    do {
                        try Auth.auth().signOut()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    return
                }
                successComplition(email)
                return
            }
            
            failComplition(FirebaseCustomError.mapFromFirebaseError(error: error))
        }
    }
    
    func signUp(name: String, authData: AuthData, successComplition: @escaping (String)->(), failComplition: @escaping (FirebaseCustomError)->()) {
        Auth.auth().createUser(withEmail: authData.email.lowercased(), password: authData.password) { [weak self] (result, error) in
            
            if let result = result, let strongSelf = self {
                strongSelf.createUser(result: result, name: name, authData: authData)
                guard let email = result.user.email else {
                    failComplition(FirebaseCustomError.unknownError)
                    return
                }
                do {
                    try Auth.auth().signOut()
                } catch let error {
                    print(error.localizedDescription)
                }
                successComplition(email)
                return
            }
            
            failComplition(FirebaseCustomError.mapFromFirebaseError(error: error))
        }
    }
    
    private func createUser(result: AuthDataResult, name: String, authData: AuthData) {
        Firestore.firestore()
            .collection(Constants.DataBase.userCollection)
            .document(authData.email)
            .setData([
                "name": name,
                "createdSince1970": Date().timeIntervalSince1970
            ])
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
