//
//  LoginViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class LoginViewController: AuthViewController {
    let loginView = LoginView()
    
    override var authView: AuthView {
        return loginView
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func buttonPressed() {
        
    }
}
