//
//  PresenterMediator.swift
//  Chat2chat
//
//  Created by Oleksiy on 27.04.2021.
//

import UIKit

protocol AuthMediator: class {
    func goToChat(viewController: UIViewController)
}

class PresenterMediator {
    
    let authPresenter: AuthPresenter
    let chatPresenter: ChatPresenter
    
    init() {
        authPresenter = AuthPresenter()
        chatPresenter = ChatPresenter()
        chatPresenter.chatViewController.presenter = chatPresenter
    }
    
    func getRootViewContoller() -> UIViewController {
        authPresenter.mediator = self
        return authPresenter.getRootViewContoller()
    }
}

extension PresenterMediator: AuthMediator {
    func goToChat(viewController: UIViewController) {
        viewController.show(chatPresenter.chatViewController, sender: self)
        chatPresenter.startChat()
    }
}
