//
//  ChatServiceDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 17.04.2021.
//

import Foundation

protocol ChatServiceDelegate: class {
    func showLoadingView()
    func hideLoadingView()
    func clearMessageTextField()
    func reloadData()
    func showDeletedChatAlert(action: @escaping ()->())
}
