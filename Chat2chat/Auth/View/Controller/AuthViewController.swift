//
//  AuthViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

class AuthViewController: UIViewController {
    private let authView: AuthView
    
    init(authView: AuthView) {
        self.authView = authView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(authView)
        authView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        authView.addConstrains()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.setTextFieldDelegate(delegate: self)
        hideKeyboardWhenTappedAround()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.shadowImage = nil
            navigationBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        }
    }
    
    func getString(from textfield: AuthTextFieldView) -> String? {
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
