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
        
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Table view delegate, source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }

}
