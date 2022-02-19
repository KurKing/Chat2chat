//
//  Message.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct Message: Equatable {
    let text: String
    let fromMe: Bool
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.fromMe == rhs.fromMe && lhs.text == rhs.text
    }
}
