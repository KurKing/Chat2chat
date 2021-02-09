//
//  ChatViewController.swift
//  Chat2chat
//
//  Created by Oleksiy on 09.02.2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chatBg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bg image
        view.addSubview(bgImageView)
        addConstraints()
    }
    
    //MARK: - addConstraints
    private func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        //bgImageView
        constraints.append(
            bgImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        )
        constraints.append(
            bgImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        )
        constraints.append(
            bgImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        )
        constraints.append(
            bgImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        )
        
        NSLayoutConstraint.activate(constraints)
    }

}
