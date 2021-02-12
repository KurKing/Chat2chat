//
//  ChatTableDelegate.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import UIKit

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if message.fromMe {
            let cell = tableView.dequeueReusableCell(withIdentifier: "self", for: indexPath) as! SelfMessageViewCell
            
            cell.setMessage(message)

            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "interlocutor", for: indexPath) as! InterlocutorMessageViewCell
            
            cell.setMessage(message)
            
            if let avatar = UIImage(named: avatarName) {
                cell.setAvatarImage(avatar)
            }

            return cell
        }
        
    }
}
