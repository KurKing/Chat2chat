//
//  SignupViewControllerPresenter.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import Foundation

protocol SignupViewControllerPresenter: AnyObject {
    func signupButtonPressed(name: String, authData: AuthData)
}
