//
//  SelfMessageViewCell.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

class SelfMessageViewCell: UITableViewCell {

    //MARK: - Views
    private var messageView: MessageView!
    
    //MARK: - Constraints
    func addConstraints(){
        
        messageView.view.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().offset(50)
            $0.trailing.equalToSuperview().offset(-5)
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
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        messageView = MessageView()
        messageView.view.backgroundColor = UIColor(named: "SelfMessageColor")

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
