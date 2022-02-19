//
//  MessageContainer.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

class MessageContainer {
    private let messages = ThreadSafeArray<Message>()
    
    var count: Int {
        messages.count
    }
    
    var isEmpty: Bool {
        messages.isEmpty
    }
    
    var isOnlyFirstMessageAdded: Bool {
        return messages.count == 1 &&
            (messages.get(index: 0)?.text ?? "") == Constants.Messages.chatStartMessage
    }
    
    var allMessages: [Message] {
        return messages.getAll()
    }
    
    func getMessage(index: Int) -> Message? {
        return messages.get(index: index)
    }
    
    func addMessage(_ message: Message) {
        removeIfNeedFirstMessage()
        messages.append(message)
    }
    
    func setMessages(_ newMessages: [Message]) {
        messages.removeAll()
        messages.append(contentsOf: newMessages)
        removeIfNeedFirstMessage()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    private func removeIfNeedFirstMessage() {
        if messages.count > 0 &&
            (messages.get(index: 0)?.text ?? "") == Constants.Messages.chatStartMessage {
            messages.remove(at: 0)
        }
    }
}
