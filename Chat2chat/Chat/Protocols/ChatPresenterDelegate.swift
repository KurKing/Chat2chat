//
//  ChatPresenterDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 17.04.2021.
//

import Foundation

protocol ChatPresenterDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func showDeletedChatAlert(action: @escaping ()->())
}
