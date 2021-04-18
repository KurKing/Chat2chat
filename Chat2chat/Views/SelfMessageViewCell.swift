//
//  SelfMessageViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

class SelfMessageViewCell: UITableViewCell {

    private var messageView: MessageView!

    func addConstraints(){
        
        messageView.view.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-3)
            $0.bottom.equalToSuperview().offset(-2)
            $0.topMargin.equalToSuperview().offset(10)
        }
        
        messageView.addConstraints()
    }
    
    func setMessage(_ message: MessageViewModel) {
        messageView.setMessage(message)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        messageView = MessageView()
        messageView.view.backgroundColor = UIColor(named: "SelfMessageColor")

        contentView.addSubview(messageView.view)
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
