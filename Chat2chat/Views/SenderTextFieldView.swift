//
//  SenderTextFieldView.swift
//  Chat2chat
//
//  Created by Oleksiy on 13.02.2021.
//

import UIKit

struct SenderTextFieldView {
    //MARK: - Views
    let sendMessageTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "BackgroundColor")
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Message", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = .systemFont(ofSize: 18)
        
        return textField
    }()

    let button: UIButton = {
        let uiButton = UIButton(type: .system)
        
        uiButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        uiButton.tintColor = UIColor(named: "UnselectedBarItemColor")
        
        return uiButton
    }()

    private let sendMessageTextFieldView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return uiView
    }()
    
    //MARK: - addConstraints
    func addConstraints(){
        sendMessageTextField.snp.makeConstraints {
            $0.topMargin.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-20)
            
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(button.snp.leading).offset(-3)
        }
        button.snp.makeConstraints {
            $0.size.equalTo(30)
            
            $0.bottom.equalToSuperview().offset(-15)
            $0.trailing.equalToSuperview().offset(-5)
        }
    }
    
    init() {
        sendMessageTextFieldView.addSubview(sendMessageTextField)
        sendMessageTextFieldView
            .addSubview(button)
    }

    var view: UIView {
        return sendMessageTextFieldView
    }
}
