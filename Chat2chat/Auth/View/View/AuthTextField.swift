//
//  AuthTextField.swift
//  Chat2chat
//
//  Created by Oleksiy on 26.04.2021.
//

import UIKit

struct AuthTextField {
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "BackgroundColor")
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 18)
        return textField
    }()
    
    let view: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "BackgroundColor")
        return uiView
    }()
    
    private let textFieldImage: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.tintColor = UIColor(named: "UnselectedBarItemColor")
        uiImageView.backgroundColor = .clear
        return uiImageView
    }()
    
    private let lineView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .gray
        return uiView
    }()
    
    init(image: UIImage, placeHolder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textFieldImage.image = image
        
        view.addSubview(textField)
        view.addSubview(textFieldImage)
    }
    
    //MARK: - Constrains
    func addConstrains(){
        view.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(50)
        }
        textFieldImage.snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(28)
            $0.leading.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(textFieldImage.snp.trailing).offset(7)
            $0.trailing.equalToSuperview().offset(-5)
            $0.centerY.equalToSuperview()
        }
    }
}
