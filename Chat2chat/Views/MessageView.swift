//
//  MessageView.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct MessageView {
    //MARK: - messageLabel
    private let messageLabel: UILabel = {
        let uilabel = UILabel()
        
        uilabel.numberOfLines = 0
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        uilabel.lineBreakMode = .byWordWrapping
        uilabel.textColor = .white
        uilabel.font = .systemFont(ofSize: 18)
        
        return uilabel
    }()
    
    //MARK: - view
    private let messageView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 10
        uiView.clipsToBounds = true
        uiView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return uiView
    }()
    
    //MARK: - addConstraints
    func addConstraints(){
        messageLabel.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            
            $0.leadingMargin.equalTo(10)
            $0.trailingMargin.equalTo(-10)
        }
    }
    
    //MARK: - Setter
    var message: Message? {
        didSet {
            guard let message = message else {
                return
            }
            
            messageLabel.text = message.text
        }
    }
    
    init() {
        messageView.addSubview(messageLabel)
    }
    
    //MARK: - getter
    var view: UIView {
        return messageView
    }
}
