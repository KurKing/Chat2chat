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
    let userToken: String
    
    func mapToViewModel(token: String) -> MessageViewModel {
        return MessageViewModel(text: text, fromMe: userToken==token)
    }
}
