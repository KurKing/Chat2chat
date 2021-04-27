//
//  SignUpViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class SignUpViewController: AuthViewController {
    let signUpView = SignUpView()
    
    override var authView: AuthView {
        return signUpView
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
