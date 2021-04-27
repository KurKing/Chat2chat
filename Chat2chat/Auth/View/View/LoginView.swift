//
//  LoginView.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

struct LoginView: AuthView {
    let emailTextField = AuthTextField(image: UIImage(systemName: "envelope") ?? UIImage(), placeHolder: "Email")
    let passwordTextField = AuthTextField(image: UIImage(systemName: "lock") ?? UIImage(), placeHolder: "Password")
    let button = AuthButton(type: .login)
    
    let view = UIView()
    
    var authButton: UIButton {
        return button.button
    }
    
    init() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(emailTextField.view)
        view.addSubview(passwordTextField.view)
        view.addSubview(button.button)

        emailTextField.textField.tag = 0
        passwordTextField.textField.tag = 1
        
        passwordTextField.textField.isSecureTextEntry = true
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
        view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        emailTextField.view.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-65)
        }
        passwordTextField.view.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        button.button.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(200)
        }
        
        button.addConstains()
        emailTextField.addConstrains()
        passwordTextField.addConstrains()
    }
}
