//
//  AuthButton.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

enum AuthButtonType: String {
    case login = "Login"
    case signup = "Sign up"
}

struct AuthButton {
    let button: UIButton = {
        let uiButton = UIButton(type: .system)
        uiButton.setTitleColor(UIColor(named: "SelfMessageColor"), for: .normal)
        uiButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        uiButton.backgroundColor = UIColor(named: "UnselectedBarItemColor")
        uiButton.layer.cornerRadius = 5
        return uiButton
    }()
    
    init(type: AuthButtonType) {
        button.setTitle(type.rawValue, for: .normal)
        button.isUserInteractionEnabled = true
    }
    
    //MARK: - Constrains
    func addConstains() {
        button.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(150)
            $0.centerX.equalToSuperview()
        }
    }
}
