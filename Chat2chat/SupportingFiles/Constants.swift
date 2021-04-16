//
//  Constants.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.03.2021.
//

import Foundation

struct Constants {
    struct DataBase {
        static let chatCollection = "Chats"
        static let messageCollection = "Messages"
        static let userToken = "userToken"
        
        static let isFreeParametr = "isFree"
        static let timeParametr = "time"
        static let textParametr = "text"
        static let shouldBeDeleted = "shouldBeDeleted"
    }
    
    struct Messages {
        static let chatStartMessage = "Chat started! Say hello to your interlocutor"
        static let endChatMessage = "Your interlocutor has finished chatting"
    }
}
