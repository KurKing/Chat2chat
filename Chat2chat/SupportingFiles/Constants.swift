//
//  Constants.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.03.2021.
//

import Foundation

struct Constants {
    static let title = "Chat2chat"
    
    struct DataBase {
        static let chatCollection = "Chats"
        static let userCollection = "Users"
        static let messageCollection = "Messages"
        static let userToken = "userToken"
        
        static let isFreeParametr = "isFree"
        static let timeParametr = "time"
        static let textParametr = "text"
        static let shouldBeDeleted = "shouldBeDeleted"
        
        static let user1 = "User1"
        static let user2 = "User2"
    }
    
    struct Messages {
        static let chatStartMessage = "Chat started! Say hello to your interlocutor"
        static let endChatMessage = "Your interlocutor has finished chatting"
    }
    
    struct Regex {
        static let email = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        // Minimum eight characters, at least one uppercase letter, one lowercase letter and one number
        static let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    }
}
