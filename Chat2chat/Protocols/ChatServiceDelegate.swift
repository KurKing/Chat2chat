//
//  ChatServiceDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 17.04.2021.
//

import Foundation

protocol ChatServiceDelegate: class {
    var messages: [MessageViewModel] { set get }
    func showLoadingView()
    func hideLoadingView()
    func clearMessageTextField()
    func showDeletedChatAlert(action: @escaping ()->())
}
