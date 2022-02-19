//
//  SenderTextFieldView.swift
//  Chat2chat
//
//  Created by Oleksiy on 13.02.2021.
//

import UIKit

class SenderTextFieldView: UIView {
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
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "BackgroundColor")
        addSubview(sendMessageTextField)
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clear() {
        sendMessageTextField.text = ""
    }
    
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
}
