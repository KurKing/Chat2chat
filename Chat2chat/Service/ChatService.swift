//
//  ChatService.swift
//  Chat2chat
//
//  Created by Oleksiy on 17.04.2021.
//

import Foundation

class ChatService: DataBaseDelegate {
    
    var chatId = ""

    private let dataBase: DataBase
    private weak var delegate: ChatServiceDelegate?
    private let messageContainer: MessageContainer
    private let userToken: String
    
    init(delegate: ChatServiceDelegate, dataBase: DataBase) {
        self.delegate = delegate
        self.dataBase = dataBase
        messageContainer = MessageContainer()
        
        if let token = UserDefaults.standard.string(forKey: Constants.DataBase.userToken){
            userToken = token[0..<6]
        } else {
            userToken = UUID().uuidString[0..<6]
            UserDefaults.standard.set(userToken, forKey: Constants.DataBase.userToken)
        }
        print("User token: \(userToken)")
        
        delegate.showLoadingView()
        dataBase.startChat(delegate: self, userToken: userToken)
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
        delegate?.showLoadingView()
        dataBase.startChat(delegate: self, userToken: userToken)
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
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty { return }
        delegate?.clearMessageTextField()
        dataBase.sendMessage(message: MessageDBEntity(text: text, time: Date().timeIntervalSince1970, userToken: userToken), chatId: chatId)
    }
}

//MARK: - DataBaseDelegate
extension ChatService {
    func clearMessages() {
        messageContainer.clearMessages()
        delegate?.showDeletedChatAlert {
            [weak self] in self?.startChat()
        }
        delegate?.reloadData()
    }
    func addMessage(message: MessageDBEntity) {
        delegate?.hideLoadingView()
        messageContainer.addMessage(
            MessageViewModel(text: message.text, fromMe: message.userToken==userToken)
        )
        delegate?.reloadData()
    }
}
