//
//  SignUpViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class SignUpViewController: AuthViewController {
    let signUpView = SignUpView()
    weak var presenter: SignupViewControllerPresenter?
    
    override var authView: AuthView {
        return signUpView
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation view
        title = "Sign Up"
    }
    
    override func buttonPressed() {
        if let data = getAuthData() {
            presenter?.signupButtonPressed(name: data.name, authData: data.authData)
        }
    }
    
    func clearTextFields() {
        signUpView.passwordTextField.clear()
        signUpView.emailTextField.clear()
        signUpView.nameTextField.clear()
    }
    
    private func getAuthData() -> (name: String, authData: AuthData)? {
        guard let name = getString(from: signUpView.nameTextField)
        else { return nil }
        
        guard let email = getString(from: signUpView.emailTextField)
        else { return nil }
        
        guard let password = getString(from: signUpView.passwordTextField)
        else { return nil }
        
        return (name: name, authData: AuthData(email: email, password: password))
    }
}
