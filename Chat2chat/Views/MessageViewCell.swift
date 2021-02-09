//
//  MessageViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit

class MessageViewCell: UITableViewCell {
    
    //MARK: - Avatar
    let avatar: UIImageView = {
        let image = UIImage(named: "avatar")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    //MARK: - label
    let label: UILabel = {
        let uilabel = UILabel()
        uilabel.text = "Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!"
        uilabel.numberOfLines = 0
        uilabel.translatesAutoresizingMaskIntoConstraints = false
        uilabel.lineBreakMode = .byWordWrapping
        uilabel.backgroundColor = UIColor(named: "BackgroundColor")
        uilabel.textColor = .white
        
        return uilabel
    }()
    
    //MARK: - StackView
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .leading
        stack.alignment = .bottom
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //MARK: - addConstraints
    private func addConstraints(){
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: -30),
            
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        stackView.addArrangedSubview(avatar)
        stackView.addArrangedSubview(label)
        
        addSubview(stackView)
        
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
