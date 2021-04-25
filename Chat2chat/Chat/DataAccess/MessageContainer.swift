//
//  MessageContainer.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

class MessageContainer {
    private(set) var messages = [MessageViewModel]()
    
    func addMessage(_ message: MessageViewModel) {
        removeIfNeedFirstMessage()
        messages.append(message)
    }
    
    func setMessages(_ messages: [MessageViewModel]) {
        self.messages = messages
        removeIfNeedFirstMessage()
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    private func removeIfNeedFirstMessage() {
        if messages.count > 0 && messages[0].text == Constants.Messages.chatStartMessage {
            messages.remove(at: 0)
        }
    }
}
