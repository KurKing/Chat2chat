//
//  PresenterMediator.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

protocol AuthMediator: AnyObject {
    func goToChat(viewController: UIViewController, email: String)
}

class PresenterMediator {
    
    let authPresenter: AuthPresenter
    let chatPresenter: ChatPresenter
    
    init() {
        authPresenter = AuthPresenter()
        chatPresenter = ChatPresenter()
        chatPresenter.delegate = chatPresenter.chatViewController
        chatPresenter.chatViewController.presenter = chatPresenter
    }
    
    func getRootViewContoller() -> UIViewController {
        authPresenter.mediator = self
        return authPresenter.getRootViewContoller()
    }
}

extension PresenterMediator: AuthMediator {
    func goToChat(viewController: UIViewController, email: String) {
        viewController.show(chatPresenter.chatViewController, sender: self)
        chatPresenter.userLogin = email
        chatPresenter.startChat()
    }
}
