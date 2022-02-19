//
//  LoginViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

final class LoginViewController: AuthViewController {
    let loginView: LoginView
    weak var presenter: LoginViewControllerPresenter?
    
    init() {
        loginView = LoginView()
        super.init(authView: loginView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        loginView.signupButton.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(authButtonPressed(_:)), for: .touchUpInside)
    }
    
    func clearTextFields() {
        loginView.passwordTextField.clear()
        loginView.emailTextField.clear()
    }
    
    func setAuthData(authData: AuthData) {
        loginView.passwordTextField.textField.text = authData.password
        loginView.emailTextField.textField.text = authData.email
    }
    
    @objc func authButtonPressed(_ sender: UIButton) {
        if let data = getAuthData() {
            presenter?.loginButtonPressed(authData: data)
        }
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
