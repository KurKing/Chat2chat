//
//  MainViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 08.02.2021.
//

import UIKit

//class MainViewController: UITabBarController {
//
//    let database = DataBase()
//    
//    //MARK: - loadView
//    override func loadView() {
//        super.loadView()
//        
//        view.backgroundColor = UIColor(named: "BackgroundColor")
//        tabBar.barTintColor = UIColor(named: "BackgroundColor")
//        
//        tabBar.tintColor = UIColor(named: "SelectedBarItemColor")
//        tabBar.unselectedItemTintColor = UIColor(named: "UnselectedBarItemColor")
//        
//    }
//    
//    //MARK: - generateChildViewControllers
//    private func generateChildViewControllers() -> [UIViewController] {
//        
//        func newTabItem(imageName: String, title: String) -> UITabBarItem{
//            let tabItem = UITabBarItem()
//            tabItem.title = title
//            tabItem.image = UIImage(systemName: imageName)
//            
//            return tabItem
//        }
//        
//        
//        let accountVC = UINavigationController(rootViewController: AccountViewController())
//        accountVC.tabBarItem = newTabItem(imageName: "person", title: "Account")
//        
//        let findChatVC = FindChatViewController()
//        findChatVC.db = db
//        let chatVC = UINavigationController(rootViewController: findChatVC)
//        chatVC.tabBarItem = newTabItem(imageName: "message", title: "Chat")
//        
//        let settingsVC = UINavigationController(rootViewController:SettingsViewController())
//        settingsVC.tabBarItem = newTabItem(imageName: "gearshape", title: "Settings")
//        
//        return [accountVC, chatVC, settingsVC]
//        
//    }
//    
//    //MARK: - viewDidLoad
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewControllers = generateChildViewControllers()
//        selectedIndex = 1
//    }
//
//}

