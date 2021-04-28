//
//  AuthService.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import Foundation
import Firebase

class AuthService {
    func login(authData: AuthData, successComplition: @escaping ()->(), failComplition: @escaping ()->()) {
        Auth.auth().signIn(withEmail: authData.email.lowercased(), password: authData.password) { (result, error) in
            if let result = result {
                successComplition()
            } else {
                failComplition()
            }
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
}
