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
        
        if !authData.isValid {
            failComplition(.incorrectPassword)
            return
        }
        
        Auth.auth().signIn(withEmail: authData.email.lowercased(), password: authData.password) { [weak self] (result, error) in
            
            if let result = result {
                guard let email = result.user.email else {
                    failComplition(FirebaseCustomError.unknownError)
                    do {
                        try Auth.auth().signOut()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    return
                }
                self?.saveAuthDataToStorage(authData: authData)
                successComplition(email)
                return
            }
            
            failComplition(FirebaseCustomError.mapFromFirebaseError(error: error))
        }
    }
    
    func signUp(name: String, authData: AuthData, successComplition: @escaping (String)->(), failComplition: @escaping (FirebaseCustomError)->()) {
        
        if let validationError = authData.validationFirebaseError {
            failComplition(validationError)
            return
        }
        
        Auth.auth().createUser(withEmail: authData.email.lowercased(), password: authData.password) { [weak self] (result, error) in
            
            if let result = result, let strongSelf = self {
                strongSelf.createUser(name: name, authData: authData)
                guard let email = result.user.email else {
                    failComplition(FirebaseCustomError.unknownError)
                    do {
                        try Auth.auth().signOut()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    return
                }
                self?.saveAuthDataToStorage(authData: authData)
                successComplition(email)
                return
            }
            
            failComplition(FirebaseCustomError.mapFromFirebaseError(error: error))
        }
    }
    
    private func createUser(name: String, authData: AuthData) {
        Firestore.firestore()
            .collection(Constants.DataBase.userCollection)
            .document(authData.email)
            .setData(["name": name])
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
}
