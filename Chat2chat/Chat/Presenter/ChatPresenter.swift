//
//  ChatPresenter.swift
//  Chat2chat
//
//  Created by Oleksiy on 17.04.2021.
//

import Foundation

class ChatPresenter: ChatDataBaseDelegate {
    
    var userLogin: String!
    var userName: String?
    var chatId = ""
    
    weak var delegate: ChatPresenterDelegate?
    let chatViewController: ChatViewController
    
    private let dataBase: ChatDataBase
    private let messageContainer: MessageContainer
    
    init(dataBase: ChatDataBase, viewController: ChatViewController, messageContainer: MessageContainer, delegate: ChatPresenterDelegate? = nil) {
        self.chatViewController = viewController
        self.dataBase = dataBase
        self.messageContainer = messageContainer
        
        if let delegate = delegate {
            self.delegate = delegate
        } else {
            self.delegate = viewController
        }
        
        viewController.presenter = self
    }
    
    var messagesCount: Int {
        return messageContainer.count
    }
    
    var isMessagesEmpty: Bool {
        return messageContainer.count == 0
    }
    
    func getMessage(index: Int) -> MessageViewModel? {
        return messageContainer.getMessage(index: index)
    }
    
    func startChat() {
        delegate?.showLoadingView()
        dataBase.startChat(delegate: self, userLogin: userLogin)
    }
    
    func endChat() {
        if !chatId.isEmpty {
            messageContainer.clearMessages()
            delegate?.reloadData()
            dataBase.endChat(delegate: self, chatId: chatId)
            startChat()
        }        
    }
    
    func sendMessage(text: String) {
        dataBase.sendMessage(message: MessageDBEntity(text: text, time: Date().timeIntervalSince1970, fromUser: userLogin), chatId: chatId)
    }
}

//MARK: - ChatDataBaseDelegate
extension ChatPresenter {
    func clearMessages() {
        messageContainer.clearMessages()
        delegate?.showDeletedChatAlert {
            [weak self] in self?.startChat()
        }
        delegate?.reloadData()
    }
    func addMessage(message: MessageDBEntity) {
        delegate?.hideLoadingView()
        messageContainer.addMessage(message.mapToViewModel(login: userLogin))
        delegate?.reloadData()
        
        if messageContainer.isOnlyFirstMessageAdded {
            dataBase.getChatInfo(chatId: chatId) { [weak self] data in
                if let self = self, let user1 = data[Constants.DataBase.user1] as? String, let user2 = data[Constants.DataBase.user2] as? String {
                    
                    self.dataBase.getName(login: user1 == self.userLogin ? user2 : user1) { [weak self] name in
                        self?.delegate?.title = name
                    }
                    
                }
            }
        }
    }
}
