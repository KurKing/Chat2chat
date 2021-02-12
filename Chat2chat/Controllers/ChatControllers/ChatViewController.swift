//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    private var chatView: ChatView!
    private(set) var messages = [Message]()
    let avatarName = "catAvatar\(Int.random(in: 1...4))"
    
    var db: DataBase?
    
    //MARK: - loadView
    override func loadView() {
        super.loadView()
        
        chatView = ChatView(dataSource: self, tableViewDelegate: self)
        
        view.addSubview(chatView.view)
        chatView.addConstraints(to: view)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.view.register(
            InterlocutorMessageViewCell.self, forCellReuseIdentifier: "interlocutor")
        chatView.view.register(
            SelfMessageViewCell.self, forCellReuseIdentifier: "self")
        
        db?.startChat(with: { [weak self] (newMessage) in
            if let vc = self {
                DispatchQueue.main.async {
                    vc.add(newMessage)
                }
            }
        })
    }
    
    /// add new message to messages array
    private func add(_ message: Message){
        messages.append(message)
        chatView.view.reloadData()
        chatView.view.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .top, animated: true)
    }
    
}
