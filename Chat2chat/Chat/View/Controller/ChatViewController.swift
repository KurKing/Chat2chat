//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit

class ChatViewController: UIViewController  {
    
    let avatarName = "catAvatar\(Int.random(in: 1...5))"
    
    weak var presenter: ChatPresenter?
    var chatView: ChatView!
        
    override func loadView() {
        super.loadView()
        
        chatView = ChatView(dataSource: self, tableViewDelegate: self)
        
        view.addSubview(chatView.bgImageView)
        view.addSubview(chatView.view)
        
        chatView.addConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // naviogation view
        title = Constants.title
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadButtonPressed(_:)))
        
        // cells registration
        chatView.tableView.registerCell(
            InterlocutorMessageViewCell.self)
        chatView.tableView.registerCell(
            SelfMessageViewCell.self)
        chatView.tableView.registerCell(
            StartedChatTableViewCell.self)
        
        // send authButton target
        chatView.textFieldView.button.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
        
        // keyboard manipulations
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func sendButtonPressed(_ sender: UIButton){
        let validator = Validator()
        guard let text = validator.validate(string: chatView.messageText) else { return }
        presenter?.sendMessage(text: text)
        chatView.clearMessageTextField()
    }
    
    @objc func reloadButtonPressed(_ sender: UIButton){
        if chatView.isLoadingViewHidden {
            presenter?.endChat()
            title = Constants.title
            dismissKeyboard()
        }
    }
    
}

//MARK: - Table data source
extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.messagesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let message = presenter?.getMessage(index: indexPath.row) else {
            return UITableViewCell()
        }
        
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
        if !(presenter?.isMessagesEmpty ?? true) {
            chatView.tableView.scrollToRow(at: IndexPath(row: (presenter?.messagesCount ?? 0) - 1, section: 0), at: .top, animated: false)
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

//MARK: - ChatPresenterDelegate
extension ChatViewController: ChatPresenterDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.chatView.tableView.reloadData()
            if !(self.presenter?.isMessagesEmpty ?? true) {
                self.chatView.tableView.scrollToRow(at: IndexPath(row: (self.presenter?.messagesCount ?? 0) - 1, section: 0), at: .top, animated: false)
            }
        }
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            self.chatView.showLoadingView()
            self.chatView.view.isUserInteractionEnabled = false
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.chatView.hideLoadingView()
            self.chatView.view.isUserInteractionEnabled = true
        }
    }
    
    func showDeletedChatAlert(action: @escaping ()->()){
        let alert = UIAlertController(title: Constants.Messages.endChatMessage, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: {_ in
            action()
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
