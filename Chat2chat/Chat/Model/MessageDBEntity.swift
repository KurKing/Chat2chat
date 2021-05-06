//
//  MessageDBEntity.swift
//  Chat2chat
//
//  Created by Oleksiy on 18.04.2021.
//

import Foundation

struct MessageDBEntity {
    let text: String
    let time: Double
    let fromUser: String
    
    func mapToViewModel(login: String) -> MessageViewModel {
        return MessageViewModel(text: text, fromMe: fromUser==login)
    }
}
