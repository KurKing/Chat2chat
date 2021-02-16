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
    let avatarName = "catAvatar\(Int.random(in: 1...5))"
    
    var db: DataBase?
    
    //MARK: - loadView
    override func loadView() {
        super.loadView()
        
        chatView = ChatView(dataSource: self, tableViewDelegate: self)
        
        view.addSubview(chatView.bgImageView)
        view.addSubview(chatView.view)
        
        chatView.addConstraints()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.tableView.register(
            InterlocutorMessageViewCell.self, forCellReuseIdentifier: "interlocutor")
        chatView.tableView.register(
            SelfMessageViewCell.self, forCellReuseIdentifier: "self")
        
        db?.startChat(with: { [weak self] (newMessage) in
            if let vc = self {
                DispatchQueue.main.async {
                    vc.add(newMessage)
                }
            }
        })
        
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        chatView.view.snp.updateConstraints {
            $0.bottom.equalToSuperview().offset(-keyboardFrame.height)
        }
        
        view.layoutIfNeeded()
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        chatView.view.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }
        view.layoutIfNeeded()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Add message
    /// add new message to messages array
    private func add(_ message: Message){
        messages.append(message)
        chatView.tableView.reloadData()
        chatView.tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .top, animated: true)
    }
    
}
