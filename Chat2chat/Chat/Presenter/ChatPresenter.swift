//
//  ChatPresenter.swift
//  Chat2chat
//
//  Created by Oleksiy on 17.04.2021.
//

import Foundation

class ChatPresenter: ChatDataBaseDelegate {
    
    private(set) lazy var chatViewController = ChatViewController()
    var chatId = ""
    var delegate: ChatPresenterDelegate {
        return chatViewController
    }

    private let dataBase: ChatDataBase
    private let messageContainer: MessageContainer
    private let userToken: String
    
    init() {
        dataBase = FirestoreChatDataBase()
        messageContainer = MessageContainer()
        
        if let token = UserDefaults.standard.string(forKey: Constants.DataBase.userToken){
            userToken = token[0..<6]
        } else {
            userToken = UUID().uuidString[0..<6]
            UserDefaults.standard.set(userToken, forKey: Constants.DataBase.userToken)
        }
        print("User token: \(userToken)")
    }
    
    var messagesCount: Int {
        return messageContainer.messages.count
    }
    
    var isMessagesEmpty: Bool {
        return messageContainer.messages.isEmpty
    }
    
    func getMessage(index: Int) -> MessageViewModel {
        return messageContainer.messages[index]
    }
    
    func startChat() {
        delegate.showLoadingView()
        dataBase.startChat(delegate: self, userToken: userToken)
    }
    
    func endChat() {
        if !chatId.isEmpty {
            messageContainer.clearMessages()
            delegate.reloadData()
            dataBase.endChat(delegate: self, chatId: chatId)
            startChat()
        }        
    }
    
    func sendMessage(text: String) {
        dataBase.sendMessage(message: MessageDBEntity(text: text, time: Date().timeIntervalSince1970, userToken: userToken), chatId: chatId)
    }
}

//MARK: - ChatDataBaseDelegate
extension ChatPresenter {
    func clearMessages() {
        messageContainer.clearMessages()
        delegate.showDeletedChatAlert {
            [weak self] in self?.startChat()
        }
        delegate.reloadData()
    }
    func addMessage(message: MessageDBEntity) {
        delegate.hideLoadingView()
        messageContainer.addMessage(message.mapToViewModel(token: userToken))
        delegate.reloadData()
    }
}
