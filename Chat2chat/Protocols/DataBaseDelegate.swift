//
//  DataBaseDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 10.03.2021.
//

import Foundation

protocol DataBaseDelegate: class {
    var chatId: String { set get }
    func clearMessages()
    func addMessage(message: MessageDBEntity)
}
