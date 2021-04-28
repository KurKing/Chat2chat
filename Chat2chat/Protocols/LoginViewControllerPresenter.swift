//
//  LoginViewControllerPresenter.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import Foundation

protocol LoginViewControllerPresenter: class {
    func loginButtonPressed(authData: AuthData)
    func signupButtonPressed()
}
