//
//  ChatDataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

protocol ChatDataBase {
    func startChat(delegate: ChatDataBaseDelegate, userToken: String)
    func endChat(delegate: ChatDataBaseDelegate, chatId: String)
    func sendMessage(message: MessageDBEntity, chatId: String)
}
