//
//  StartedChatTableViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 20.03.2021.
//

import UIKit

class StartedChatTableViewCell: UITableViewCell {
    
    private var messageView: MessageView!

    func addConstraints(){
        
        messageView.view.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
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
        messageView.label.textAlignment = .center
        messageView.label.font = .systemFont(ofSize: 12)
        messageView.label.text = Constants.Messages.chatStartMessage

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
