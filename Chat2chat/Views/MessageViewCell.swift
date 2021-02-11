//
//  MessageViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit
import SnapKit

class MessageViewCell: UITableViewCell {
    
    //MARK: - Avatar
    let avatar: UIImageView = {
        let image = UIImage(named: "avatar\(Int.random(in: 0...2))")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    //MARK: - messageLabel
    let messageLabel: UILabel = {
        let uilabel = UILabel()
        uilabel.text = "\(pow(10,Int.random(in: 1...6)))"
        uilabel.numberOfLines = 0
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        uilabel.lineBreakMode = .byWordWrapping
        uilabel.textColor = .white
        uilabel.font = .systemFont(ofSize: 18, weight: .light)
        
        return uilabel
    }()
    
    //MARK: - view
    let messageView: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 10
        uiView.clipsToBounds = true
        uiView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return uiView
    }()
    
    //MARK: - addConstraints
    private func addConstraints(){
        avatar.snp.makeConstraints {
            $0.size.equalTo(40)
            
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview()
        }
        
        messageView.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(5)
            $0.trailing.lessThanOrEqualTo(contentView.bounds.width-100)
            $0.bottom.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints {
            $0.topMargin.equalTo(7)
            $0.bottomMargin.equalTo(-7)
            
            $0.leadingMargin.equalTo(7)
            $0.trailingMargin.equalTo(-7)
        }
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        messageView.addSubview(messageLabel)
        
        addSubview(avatar)
        addSubview(messageView)
        
        addConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
