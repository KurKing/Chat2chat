//
//  ChatDataBaseDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 10.03.2021.
//

import Foundation

protocol ChatDataBaseDelegate: AnyObject {
    var chatId: String { set get }
    func clearMessages()
    func addMessage(message: MessageDBEntity)
}
