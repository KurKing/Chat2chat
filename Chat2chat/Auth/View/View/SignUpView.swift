//
//  SignUpView.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

struct SignUpView: AuthView {
    let nameTextField = AuthTextField(image: UIImage(systemName: "person") ?? UIImage(), placeHolder: "Name")
    let emailTextField = AuthTextField(image: UIImage(systemName: "envelope") ?? UIImage(), placeHolder: "Email")
    let passwordTextField = AuthTextField(image: UIImage(systemName: "lock") ?? UIImage(), placeHolder: "Password")
    let button = AuthButton(type: .signup)
    
    let view = UIView()
    
    var authButton: UIButton {
        return button.button
    }
    
    init() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(nameTextField.view)
        view.addSubview(emailTextField.view)
        view.addSubview(passwordTextField.view)
        view.addSubview(button.button)
        
        nameTextField.textField.tag = 0
        emailTextField.textField.tag = 1
        passwordTextField.textField.tag = 2
        
        passwordTextField.textField.isSecureTextEntry = true
    }
    
    func setTextFieldDelegate(delegate: UITextFieldDelegate) {
        nameTextField.textField.delegate = delegate
        emailTextField.textField.delegate = delegate
        passwordTextField.textField.delegate = delegate
    }
    
    func getTextField(tag: Int) -> UITextField? {
        switch tag {
        case 0:
            return nameTextField.textField
        case 1:
            return emailTextField.textField
        case 2:
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
        nameTextField.view.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-130)
        }
        emailTextField.view.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-65)
        }
        passwordTextField.view.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        button.button.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
        }
        
        button.addConstains()
        nameTextField.addConstrains()
        emailTextField.addConstrains()
        passwordTextField.addConstrains()
    }
}
