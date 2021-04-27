//
//  SignUpViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let signUpView = SignUpView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(signUpView.view)
        if view.bounds.width > 650 {
            signUpView.view.snp.makeConstraints {
                $0.width.equalTo(650)
            }
        } else {
            signUpView.view.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        signUpView.addConstrains()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setTextFieldDelegate(delegate: self)
        hideKeyboardWhenTappedAround()
        
        signUpView.button.button.addTarget(self, action: #selector(signupButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func signupButtonPressed(_ sender: UIButton) {
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = signUpView
                .getTextField(tag: textField.tag + 1) else {
            textField.resignFirstResponder()
            return true
        }
        nextTextField.becomeFirstResponder()
        return true
    }
}
