//
//  AuthButton.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

class AuthButton: UIButton {
    enum AuthButtonType: String {
        case login = "Log in"
        case signup = "Sign up"
    }
    
    init(type: AuthButtonType) {
        super.init(frame: .zero)
        
        setTitle(type.rawValue, for: .normal)
        isUserInteractionEnabled = true
        setTitleColor(UIColor(named: "SelfMessageColor"), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        backgroundColor = UIColor(named: "UnselectedBarItemColor")
        layer.cornerRadius = 5
        
        addConstains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constrains
    func addConstains() {
        snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(150)
        }
    }
}
