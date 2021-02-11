//
//  ChatView.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct ChatView {

    //MARK: - bgImageView
    private let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chatBg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    //MARK: - chatTableView
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MessageViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //MARK: - addConstraints
    func addConstraints(view: UIView){
        var constraints = [NSLayoutConstraint]()
        
        //full screen constraints
        for i in [bgImageView, chatTableView]{
            constraints.append(
                i.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            )
            constraints.append(
                i.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            )
            constraints.append(
                i.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            )
            constraints.append(
                i.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - init
    init(dataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        chatTableView.dataSource = dataSource
        chatTableView.delegate = tableViewDelegate
        
        chatTableView.backgroundView = bgImageView
    }
    
    //MARK: - view getter
    var view: UIView {
        return chatTableView
    }
}
