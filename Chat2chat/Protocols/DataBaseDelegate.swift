//
//  DataBaseDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 10.03.2021.
//

import Foundation

protocol DataBaseDelegate {
    func hideLoadingView()
    func showLoadingView()
    func clearMessages()
    func addMessage(message: Message)
}
