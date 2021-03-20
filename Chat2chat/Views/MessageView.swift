//
//  MessageView.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct MessageView {
    let label: UILabel = {
        let uilabel = UILabel()
        
        uilabel.numberOfLines = 0
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        uilabel.lineBreakMode = .byWordWrapping
        uilabel.textColor = .white
        uilabel.font = .systemFont(ofSize: 18)
        
        return uilabel
    }()

    let view: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 10
        uiView.clipsToBounds = true
        uiView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return uiView
    }()
    
    func addConstraints(){
        label.snp.makeConstraints {
            $0.topMargin.equalTo(10)
            $0.bottomMargin.equalTo(-10)
            
            $0.leadingMargin.equalTo(10)
            $0.trailingMargin.equalTo(-10)
        }
    }

    func setMessage(_ message: Message) {
        label.text = message.text
    }
    
    init() {
        view.addSubview(label)
    }
}
