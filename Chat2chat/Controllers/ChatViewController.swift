//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chatBg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MessageViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    //MARK: - loadView
    override func loadView() {
        super.loadView()
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.backgroundView = bgImageView
        view.addSubview(chatTableView)
        addConstraints()
    }
    
    //MARK: - addConstraints
    private func addConstraints(){
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
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Table view delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }

}
