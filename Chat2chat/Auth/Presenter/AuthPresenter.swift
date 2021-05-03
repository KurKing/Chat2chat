//
//  AuthPresenter.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

class AuthPresenter {
    lazy var signUpViewController = SignUpViewController()
    var loginViewController = LoginViewController()
    
    weak var mediator: AuthMediator?
    
    private let authService = AuthService()
    
    func getRootViewContoller() -> UIViewController {
        loginViewController.presenter = self
        
        if let authData = getAuthDataFromUserDefaults() {
            loginViewController.authView.getTextField(tag: 0)?.text = authData.email
            loginViewController.authView.getTextField(tag: 1)?.text = authData.password
        }
        
        return UINavigationController(rootViewController: loginViewController)
    }
    
    private func getAuthDataFromUserDefaults() -> AuthData? {
        guard let login = getStringFromUserDefaults(key: "login")
        else {
            return nil
        }
        guard let password = getStringFromUserDefaults(key: "password")
        else {
            return nil
        }
        
        return AuthData(email: login, password: password)
    }
    private func getStringFromUserDefaults(key: String) -> String? {
        let validator = Validator()
        return validator.validate(string: UserDefaults.standard.string(forKey: key))
    }
}

extension AuthPresenter: LoginViewControllerPresenter {
    func signupButtonPressed() {
        loginViewController.show(signUpViewController, sender: self)
        signUpViewController.presenter = self
    }
    func loginButtonPressed(authData: AuthData) {
        authService.login(authData: authData) { [weak self] in
            if let strongSelf = self {
                strongSelf.mediator?.goToChat(viewController: strongSelf.loginViewController)
            }
        } failComplition: { [weak self] in
            if let strongSelf = self {
                strongSelf.loginViewController.clearTextFields()
            }
        }
    }
}

extension AuthPresenter: SignupViewControllerPresenter {
    func signupButtonPressed(name: String, authData: AuthData) {
        authService.signUp(name: name, authData: authData) { [weak self] in
            if let strongSelf = self {
                print("success")
                strongSelf.mediator?.goToChat(viewController: strongSelf.signUpViewController)
            }
        } failComplition: { [weak self] in
            if let strongSelf = self {
                print("fail")
                strongSelf.signUpViewController.clearTextFields()
            }
        }
    }
}
