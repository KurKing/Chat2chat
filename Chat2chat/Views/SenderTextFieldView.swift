//
//  SenderTextFieldView.swift
//  Chat2chat
//
//  Created by Oleksiy on 13.02.2021.
//

import UIKit

struct SenderTextFieldView {
    //MARK: - TextField
    let sendMessageTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "BackgroundColor")
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Message", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = .systemFont(ofSize: 18)
        
        return textField
    }()
    
    //MARK: - Button
    
    
    //MARK: - view
    private let sendMessageTextFieldView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return uiView
    }()
    
    //MARK: - addConstraints
    func addConstraints(){
        sendMessageTextField.snp.makeConstraints {
            $0.topMargin.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-15)
            
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
    init() {
        sendMessageTextFieldView.addSubview(sendMessageTextField)
    }
    
    //MARK: - getter
    var view: UIView {
        return sendMessageTextFieldView
    }
}
