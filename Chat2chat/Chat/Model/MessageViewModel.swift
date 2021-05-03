//
//  MessageViewModel.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct MessageViewModel: Equatable {
    let text: String
    let fromMe: Bool
    
    static func == (lhs: MessageViewModel, rhs: MessageViewModel) -> Bool {
        return lhs.fromMe == rhs.fromMe && lhs.text == rhs.text
    }
}
