//
//  ChatPresenterProtocol.swift
//  Chat2chat
//
//  Created by Oleksiy on 24.06.2021.
//

import Foundation

protocol ChatPresenterProtocol: AnyObject {
    func sendMessage(text: String)
    func getMessage(index: Int) -> MessageViewModel?
    func endChat()
    
    var isMessagesEmpty: Bool { get }
    var messagesCount: Int { get }
}
