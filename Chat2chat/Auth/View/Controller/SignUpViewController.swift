//
//  SignUpViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

final class SignUpViewController: AuthViewController {
    let signUpView: SignUpView
    weak var presenter: SignupViewControllerPresenter?
    
    init() {
        signUpView = SignUpView()
        super.init(authView: signUpView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign Up"
        signUpView.button.addTarget(self, action: #selector(authButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func authButtonPressed(_ sender: UIButton) {
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
