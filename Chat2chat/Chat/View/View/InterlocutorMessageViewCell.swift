//
//  InterlocutorMessageViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit
import SnapKit

class InterlocutorMessageViewCell: UITableViewCell {
    
    var image: UIImage? {
        set {
            avatar.image = newValue
        }
        get {
            avatar.image
        }
    }
    
    private let avatar: UIImageView = {
        let image = UIImage(named: "noavatar")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var messageView: MessageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        messageView = MessageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(avatar)
        contentView.addSubview(messageView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMessage(_ message: Message) {
        messageView.setMessage(message)
    }
    
    func addConstraints(){
        avatar.snp.makeConstraints {
            $0.size.equalTo(40)
            
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-2)
        }
        
        messageView.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(5)
            $0.trailing.lessThanOrEqualToSuperview().offset(-50)
            $0.bottom.equalToSuperview().offset(-2)
            $0.topMargin.equalToSuperview().offset(10)
        }
        
        messageView.addConstraints()
    }
}
