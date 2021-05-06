//
//  AuthViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    var authView: AuthView {
        return emptyAuthView()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(authView.view)
        if view.bounds.width > 650 {
            authView.view.snp.makeConstraints {
                $0.width.equalTo(650)
            }
        } else {
            authView.view.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        authView.addConstrains()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authView.setTextFieldDelegate(delegate: self)
        hideKeyboardWhenTappedAround()
        
        authView.authButton.addTarget(self, action: #selector(authButtonPressed(_:)), for: .touchUpInside)
    }
    
    func buttonPressed() {}
    
    func getString(from textfield: AuthTextField) -> String? {
        let validator = Validator()
        guard let string = validator.validate(string: textfield.text) else {
            textfield.clear()
            textfield.ping()
            return nil
        }
        return string
    }
    
    func showErrorAlert(errorMessage: String) {
        let alertViewController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
    @objc private func authButtonPressed(_ sender: UIButton) {
        buttonPressed()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private struct emptyAuthView: AuthView {
        var view = UIView()
        var authButton = UIButton()
        func setTextFieldDelegate(delegate: UITextFieldDelegate) {}
        func getTextField(tag: Int) -> UITextField? { return nil }
        func addConstrains() {}
    }
}

//MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = authView
                .getTextField(tag: textField.tag + 1) else {
            textField.resignFirstResponder()
            return true
        }
        nextTextField.becomeFirstResponder()
        return true
    }
}
