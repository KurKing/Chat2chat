//
//  MainViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 08.02.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        tabBar.barTintColor = UIColor(named: "BackgroundColor")
        
        tabBar.tintColor = UIColor(named: "SelectedBarItemColor")
        tabBar.unselectedItemTintColor = UIColor(named: "UnselectedBarItemColor")
        
        viewControllers = generateChildViewControllers()
        selectedIndex = 0
    }
    
    //MARK: - generateChildViewControllers
    private func generateChildViewControllers() -> [UIViewController] {
        
        func newTabItem(imageName: String, title: String) -> UITabBarItem{
            let tabItem = UITabBarItem()
            tabItem.title = title
            tabItem.image = UIImage(systemName: imageName)
            
            return tabItem
        }
        
        let accountVC = AccountViewController()
        accountVC.tabBarItem = newTabItem(imageName: "person", title: "Account")
        
        let chatVC = ChatViewController()
        chatVC.tabBarItem = newTabItem(imageName: "message", title: "chat")
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = newTabItem(imageName: "gearshape", title: "Settings")
        
        return [accountVC, chatVC, settingsVC]
        
        
    }
}

