//
//  LoginViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class LoginViewController: AuthViewController {
    let loginView = LoginView()
    weak var presenter: LoginViewControllerPresenter?
    
    override var authView: AuthView {
        return loginView
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.signupButton.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
        
        // naviogation view
        title = "Log in"
    }
    
    override func buttonPressed() {
        if let data = getAuthData() {
            presenter?.loginButtonPressed(authData: data)
        }
    }
    
    func clearTextFields() {
        loginView.passwordTextField.clear()
        loginView.emailTextField.clear()
    }
    
    func setAuthData(authData: AuthData) {
        loginView.passwordTextField.textField.text = authData.password
        loginView.emailTextField.textField.text = authData.email
    }
    
    @objc private func signUpButtonPressed(_ sender: UIButton) {
        presenter?.signupButtonPressed()
    }
    
    private func getAuthData() -> AuthData? {
        guard let email = getString(from: loginView.emailTextField)
        else { return nil }
        
        guard let password = getString(from: loginView.passwordTextField)
        else { return nil }
        
        return AuthData(email: email, password: password)
    }
}
