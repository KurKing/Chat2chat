//
//  InterlocutorMessageViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit
import SnapKit

class InterlocutorMessageViewCell: UITableViewCell {
    
    //MARK: - Views
    private let avatar: UIImageView = {
        let image = UIImage(named: "noavatar")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private var messageView: MessageView!
    
    //MARK: - Constraints
    func addConstraints(){
        avatar.snp.makeConstraints {
            $0.size.equalTo(40)
            
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview()
        }
        
        messageView.view.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(5)
            $0.trailing.lessThanOrEqualToSuperview().offset(-50)
            $0.bottom.equalToSuperview()
            $0.topMargin.equalToSuperview().offset(10)
        }
        
        messageView.addConstraints()
    }
    
    //MARK: - Setter
    var message: Message? {
        didSet {
            guard let message = message else {
                return
            }
            
            messageView.message = message
        }
    }
    
    var avatarImage: UIImage? {
        didSet {
            if let avatarImage = avatarImage {
                avatar.image = avatarImage
            }
        }
    }
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        messageView = MessageView()
        
        addSubview(avatar)
        addSubview(messageView.view)
        
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
