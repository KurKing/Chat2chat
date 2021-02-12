//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var chatView: ChatView!
    
    //MARK: - loadView
    override func loadView() {
        super.loadView()
        
        chatView = ChatView(dataSource: self, tableViewDelegate: self)
        
        view.addSubview(chatView.view)
        chatView.addConstraints(view: view)
        
        title = "Chat"
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColor")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.tableView.register(InterlocutorMessageViewCell.self, forCellReuseIdentifier: "interlocutor")
        chatView.tableView.register(SelfMessageViewCell.self, forCellReuseIdentifier: "self")
    }
    
    //MARK: - Table view delegate, source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var message = ""
        for _ in 0...Int.random(in: 1...3) {
            message += "Lorem ipsum"
        }
        
        if Bool.random() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "self", for: indexPath) as! SelfMessageViewCell
            
            cell.setMessage(Message(text: message, time: "12:30"))

            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "interlocutor", for: indexPath) as! InterlocutorMessageViewCell
        
        cell.setMessage(Message(text: message, time: "12:30"))
        cell.setAvatarImage(UIImage(named: "avatar\(Int.random(in: 1...2))")!) 

        return cell
    }

}
