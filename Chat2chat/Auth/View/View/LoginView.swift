//
//  LoginView.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

class LoginView: UIView, AuthView {
    let emailTextField = AuthTextFieldView(image: UIImage(systemName: "envelope") ?? UIImage(), placeHolder: "Email")
    let passwordTextField = AuthTextFieldView(image: UIImage(systemName: "lock") ?? UIImage(), placeHolder: "Password")
    let loginButton = AuthButton(type: .login)
    let signupButton = AuthButton(type: .signup)

    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "BackgroundColor")
        
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signupButton)

        emailTextField.textField.tag = 0
        passwordTextField.textField.tag = 1
        
        passwordTextField.textField.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextFieldDelegate(delegate: UITextFieldDelegate) {
        emailTextField.textField.delegate = delegate
        passwordTextField.textField.delegate = delegate
    }
    
    func getTextField(tag: Int) -> UITextField? {
        switch tag {
        case 0:
            return emailTextField.textField
        case 1:
            return passwordTextField.textField
        default:
            return nil
        }
    }
    
    //MARK: - Add Constrains
    func addConstrains() {
        snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-130)
        }
        passwordTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-65)
        }
        loginButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview().offset(-90)
        }
        signupButton.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview().offset(90)
        }
        
        loginButton.addConstains()
        signupButton.addConstains()
        emailTextField.addConstrains()
        passwordTextField.addConstrains()
    }
}
