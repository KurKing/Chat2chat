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
    let view: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    //MARK: - addConstraints
    func addConstraints(to rootView: UIView){
        var constraints = [NSLayoutConstraint]()
        
        //full screen constraints
        for i in [bgImageView, view]{
            constraints.append(
                i.leadingAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.leadingAnchor)
            )
            constraints.append(
                i.trailingAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.trailingAnchor)
            )
            constraints.append(
                i.topAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.topAnchor)
            )
            constraints.append(
                i.bottomAnchor.constraint(equalTo: rootView.safeAreaLayoutGuide.bottomAnchor)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - init
    init(dataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        view.dataSource = dataSource
        view.delegate = tableViewDelegate
        
        view.backgroundView = bgImageView
    }
}
