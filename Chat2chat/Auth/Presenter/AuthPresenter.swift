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
        
        if let authData = authService.getAuthDataFromStorage() {
            loginViewController.setAuthData(authData: authData)
        }
        
        return UINavigationController(rootViewController: loginViewController)
    }
}

//MARK: - LoginViewControllerPresenter
extension AuthPresenter: LoginViewControllerPresenter {
    func signupButtonPressed() {
        loginViewController.show(signUpViewController, sender: self)
        signUpViewController.presenter = self
    }
    func loginButtonPressed(authData: AuthData) {
        authService.login(authData: authData) { [weak self] email in
            if let strongSelf = self {
                strongSelf.mediator?.goToChat(viewController: strongSelf.loginViewController, email: email)
            }
        } failComplition: { [weak self] error in
            self?.loginViewController.showErrorAlert(errorMessage: error.rawValue)
        }
    }
}

//MARK: - SignupViewControllerPresenter
extension AuthPresenter: SignupViewControllerPresenter {
    func signupButtonPressed(name: String, authData: AuthData) {
        authService.signUp(name: name, authData: authData)
        { [weak self] email in
            if let strongSelf = self {
                strongSelf.mediator?.goToChat(viewController: strongSelf.signUpViewController, email: email)
            }
        } failComplition: { [weak self] error in
            self?.signUpViewController.showErrorAlert(errorMessage: error.rawValue)
        }
    }
}
