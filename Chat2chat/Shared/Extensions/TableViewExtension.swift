//
//  TableViewExtension.swift
//  Chat2chat
//
//  Created by Oleksiy on 20.03.2021.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_: T.Type) where T: ReusableCell {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
 
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T where T: ReusableCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
}
