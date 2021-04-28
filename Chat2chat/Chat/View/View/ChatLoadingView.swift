//
//  ChatLoadingView.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.03.2021.
//

import UIKit

struct ChatLoadingView {
    //MARK: - Views
    private let labelBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "SelfMessageColor")
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        return view
    }()
    
    private let label: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = "Finding new chat..."
        uiLabel.backgroundColor = .clear
        uiLabel.textColor = .white
        uiLabel.font = .systemFont(ofSize: 16, weight: .bold)
        return uiLabel
    }()
    
    //MARK: - addConstraints
    func addConstraints(){
        labelBackground.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    init() {
        labelBackground.addSubview(label)
    }
    
    var view: UIView {
        return labelBackground
    }
}
