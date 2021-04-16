//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    private var database: DataBase?
    
    private(set) var chatView: ChatView!
    private(set) var loadingView: LoadingView!
    
    fileprivate(set) var messages = [Message]()
    
    let avatarName = "catAvatar\(Int.random(in: 1...5))"
    
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
        
        database = DataBase(delegate: self)
        
        // naviogation view
        title = "Chat2chat"
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadButtonPressed(_:)))
        
        // cells registration
        chatView.tableView.registerCell(
            InterlocutorMessageViewCell.self)
        chatView.tableView.registerCell(
            SelfMessageViewCell.self)
        chatView.tableView.registerCell(
            StartedChatTableViewCell.self)
        
        // send button target
        chatView.textFieldView.button.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
        
        // load chat
        showLoadingView()
        DispatchQueue.global(qos: .background).async {
            self.database?.startChat()
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
            DispatchQueue.global(qos: .userInteractive).async {
                self.database?.sendMessage(Message(text: validatedText, fromMe: true))
            }
            chatView.messageText = ""
        }
        
    }
    
    @objc func reloadButtonPressed(_ sender: UIButton){
        DispatchQueue.global(qos: .background).async {
            self.database?.deleteChat()
        }
        messages = []
        chatView.tableView.reloadData()
        showLoadingView()
        
        DispatchQueue.global(qos: .userInteractive).async{
            self.database?.startChat()
        }
        
        dismissKeyboard()
    }

}

//MARK: - Table data source
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if message.text == Constants.Messages.chatStartMessage {
            return tableView.dequeueReusableCell(type: StartedChatTableViewCell.self)
        }
        
        if message.fromMe {
            
            let cell = tableView.dequeueReusableCell(type: SelfMessageViewCell.self)
            cell.setMessage(message)
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(type: InterlocutorMessageViewCell.self)
        cell.setMessage(message)
        if let avatar = UIImage(named: avatarName) {
            cell.setAvatarImage(avatar)
        }
        return cell
        
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
        if !messages.isEmpty {
            chatView.tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .top, animated: false)
        }
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
        DispatchQueue.main.async {
            self.loadingView.view.alpha = 1
            self.chatView.textFieldView.sendMessageTextField.isEnabled = false
            self.chatView.textFieldView.button.isEnabled = false
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.view.alpha = 0
            self.chatView.textFieldView.sendMessageTextField.isEnabled = true
            self.chatView.textFieldView.button.isEnabled = true
        }
    }
    
    func clearMessages() {
        DispatchQueue.main.async {
            self.messages = []
            self.chatView.tableView.reloadData()
            self.showLoadingView()
            self.showDeletedChatAlert()
        }
    }
    
    func addMessage(message: Message){
        DispatchQueue.main.async {
            if self.messages.count == 1 && self.messages[0].text == Constants.Messages.chatStartMessage {
                self.messages = []
            }
            
            self.hideLoadingView()
            self.messages.append(message)
            self.chatView.tableView.reloadData()
            self.chatView.tableView.scrollToRow(at: IndexPath(row: self.messages.count-1, section: 0), at: .top, animated: true)
        }
    }
}

//MARK: - Alert
extension ChatViewController {
    private func showDeletedChatAlert(){
        let alert = UIAlertController(title: Constants.Messages.endChatMessage, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { [weak self] _ in
            DispatchQueue.global(qos: .userInteractive).async{
                self?.database?.startChat()
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
