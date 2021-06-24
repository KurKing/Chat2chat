//
//  MessageContainer.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

class MessageContainer {
    private let messages = ThreadSafeArray<MessageViewModel>()
    
    var count: Int {
        messages.count
    }
    
    var isOnlyFirstMessageAdded: Bool {
        return messages.count == 1 &&
            (messages.get(index: 0)?.text ?? "") == Constants.Messages.chatStartMessage
    }
    
    func getMessage(index: Int) -> MessageViewModel? {
        return messages.get(index: index)
    }
    
    func addMessage(_ message: MessageViewModel) {
        removeIfNeedFirstMessage()
        messages.append(message)
    }
    
    func setMessages(_ newMessages: [MessageViewModel]) {
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
