//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    private var database: DataBase!
    private(set) var chatView: ChatView!
    private(set) var loadingView: LoadingView!
    fileprivate var messages = [Message](){
        didSet {
            if messages.isEmpty {
                showLoadingView()
            }
        }
    }
    
    let avatarName = "catAvatar\(Int.random(in: 1...5))"
    
    private var chatComplition: ((Message)->())!
    
    override func loadView() {
        super.loadView()
        
        chatView = ChatView(dataSource: self, tableViewDelegate: self)
        loadingView = LoadingView()
        
        view.addSubview(chatView.bgImageView)
        view.addSubview(chatView.view)
        view.addSubview(loadingView.view)
        
        chatView.addConstraints()
        loadingView.addConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = DataBase(delegate: self, complition: { [weak self] (message) in
            if let vc = self {
                DispatchQueue.main.async {
                    vc.add(message: message)
                }
            }
        })
        
        // naviogation view
        title = "Chat2chat"
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadButtonPressed(_:)))
        
        // cells registration
        chatView.tableView.register(
            InterlocutorMessageViewCell.self, forCellReuseIdentifier: "interlocutor")
        chatView.tableView.register(
            SelfMessageViewCell.self, forCellReuseIdentifier: "self")
        
        // send button target
        chatView.textFieldView.button.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
        
        // load chat
        chatComplition = { [weak self] (message) in
            if let vc = self {
                DispatchQueue.main.async {
                    vc.add(message: message)
                }
            }
        }
        
        showLoadingView()
        
        DispatchQueue.global(qos: .background).async { [self] in
            self.database.startChat()
        }
        
        // keyboard manipulations
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func sendButtonPressed(_ sender: UIButton){
        
        guard let text = chatView.messageText else {
            return
        }
        
        let validatedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if validatedText != "" {
            database.sendMessage(Message(text: validatedText, fromMe: true))
            chatView.messageText = ""
        }

    }
    
    @objc func reloadButtonPressed(_ sender: UIButton){
        database.deleteChat()
        messages = []
        database.startChat()
    }
            
    private func add(message: Message){
        hideLoadingView()
        messages.append(message)
        chatView.tableView.reloadData()
        chatView.tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .top, animated: true)
    }
    
    private func showDeletedChatAlert(){
        let alert = UIAlertController(title: "Your interlocutor has finished chatting", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { [weak self] _ in
            self?.database.startChat()
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

//MARK: - Table data source
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if message.fromMe {
            let cell = tableView.dequeueReusableCell(withIdentifier: "self", for: indexPath) as! SelfMessageViewCell
            
            cell.setMessage(message)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "interlocutor", for: indexPath) as! InterlocutorMessageViewCell
            
            cell.setMessage(message)
            
            if let avatar = UIImage(named: avatarName) {
                cell.setAvatarImage(avatar)
            }
            
            return cell
        }
        
    }
}

//MARK: - Keyboard
private extension ChatViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        chatView.view.snp.updateConstraints {
            $0.bottom.equalToSuperview().offset(-keyboardFrame.height)
        }
        
        view.layoutIfNeeded()
        chatView.tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .top, animated: false)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        chatView.view.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }
        view.layoutIfNeeded()
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        chatView.tableView.addGestureRecognizer(tap)
    }
}

//MARK: - DataBaseDelegate
extension ChatViewController: DataBaseDelegate {
    func showLoadingView() {
        loadingView.view.alpha = 1
    }
    
    func hideLoadingView() {
        loadingView.view.alpha = 0
    }
    
    func clearMessages() {
        messages = []
        showDeletedChatAlert()
    }
    
    
}
