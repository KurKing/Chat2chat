//
//  MessageView.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

class MessageView: UIView {
    
    let label: UILabel = {
        let uilabel = UILabel()
        
        uilabel.numberOfLines = 0
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        uilabel.lineBreakMode = .byWordWrapping
        uilabel.textColor = .white
        uilabel.font = .systemFont(ofSize: 18)
        
        return uilabel
    }()
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(named: "BackgroundColor")
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMessage(_ message: Message) {
        label.text = message.text
    }
    
    func addConstraints(){
        label.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            
            $0.leadingMargin.equalTo(10)
            $0.trailingMargin.equalTo(-10)
        }
    }
}
