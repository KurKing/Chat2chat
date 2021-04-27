//
//  PresenterMediator.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

class PresenterMediator {
    
    let authPresenter: AuthPresenter
    let chatPresenter: ChatPresenter
    
    init() {
        authPresenter = AuthPresenter()
        chatPresenter = ChatPresenter()
        chatPresenter.chatViewController.presenter = chatPresenter
        // TODO:
        chatPresenter.startChat()
    }
    
    func getRootViewContoller() -> UIViewController {
        return UINavigationController(rootViewController: chatPresenter.chatViewController)
    }
}
