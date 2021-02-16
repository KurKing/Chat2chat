//
//  ChatView.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct ChatView {

    //MARK: - bgImageView
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chatBg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    //MARK: - chatTableView
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    //MARK: - view
    let view  = UIView()
    
    //MARK: - textFieldView
    let textFieldView: SenderTextFieldView
    
    //MARK: - addConstraints
    func addConstraints(){
        bgImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints {
            $0.bottom.equalTo(textFieldView.view.snp.top)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        textFieldView.view.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(100)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        textFieldView.addConstraints()
    }
    
    //MARK: - init
    init(dataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        
        textFieldView = SenderTextFieldView()
        
        tableView.dataSource = dataSource
        tableView.delegate = tableViewDelegate
        
        view.addSubview(tableView)
        view.addSubview(textFieldView.view)

    }
}
