//
//  ChatDataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

protocol ChatDataBase {
    func startChat(delegate: ChatDataBaseDelegate, userLogin: String)
    func endChat(delegate: ChatDataBaseDelegate, chatId: String)
    func sendMessage(message: MessageDBEntity, chatId: String)
    func getName(login: String, complition: @escaping (String)->())
    func getChatInfo(chatId: String, complition: @escaping ([String:Any])->())
}
