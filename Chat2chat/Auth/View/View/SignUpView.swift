//
//  SignUpView.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class SignUpView: UIView, AuthView {
    let nameTextField = AuthTextFieldView(image: UIImage(systemName: "person") ?? UIImage(), placeHolder: "Name")
    let emailTextField = AuthTextFieldView(image: UIImage(systemName: "envelope") ?? UIImage(), placeHolder: "Email")
    let passwordTextField = AuthTextFieldView(image: UIImage(systemName: "lock") ?? UIImage(), placeHolder: "Password")
    let button = AuthButton(type: .signup)
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "BackgroundColor")
        
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(button)
        
        nameTextField.textField.tag = 0
        emailTextField.textField.tag = 1
        passwordTextField.textField.tag = 2
        
        passwordTextField.textField.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        nameTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-130)
        }
        emailTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-65)
        }
        passwordTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
        }
        
        button.addConstains()
        nameTextField.addConstrains()
        emailTextField.addConstrains()
        passwordTextField.addConstrains()
    }
}
