//
//  DataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

protocol DataBase {
    func startChat(delegate: DataBaseDelegate, userToken: String)
    func endChat(delegate: DataBaseDelegate, chatId: String)
    func sendMessage(message: MessageDBEntity, chatId: String)
}
