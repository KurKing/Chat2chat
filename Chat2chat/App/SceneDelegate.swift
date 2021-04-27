//
//  SceneDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 08.02.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
//        let chatViewController = ChatViewController()
//        chatViewController.setPresenter(presenter: ChatPresenter(
//            delegate: chatViewController, dataBase: FirestoreChatDataBase()))
//        chatViewController.loadView()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
//        window?.rootViewController = UINavigationController(rootViewController: chatViewController)
        window?.rootViewController = SignUpViewController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
