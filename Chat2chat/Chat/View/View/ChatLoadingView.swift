//
//  ChatLoadingView.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.03.2021.
//

import UIKit

class ChatLoadingView: UIView {
    
    private let label: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Finding new chat..."
        uiLabel.backgroundColor = .clear
        uiLabel.textColor = .white
        uiLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return uiLabel
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(named: "SelfMessageColor")
        layer.cornerRadius = 7
        clipsToBounds = true
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
}
