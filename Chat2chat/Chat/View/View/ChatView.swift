//
//  ChatView.swift
//  Chat2chat
//
//  Created by Oleksiy on 11.02.2021.
//

import UIKit

struct ChatView {
    
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chatBg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    let view  = UIView()
    let textFieldView: SenderTextFieldView
    let loadingView = ChatLoadingView()
    
    var messageText: String? {
        set{
            textFieldView.sendMessageTextField.text = newValue
        }
        get {
            return textFieldView.sendMessageTextField.text
        }
    }

    init(dataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        
        textFieldView = SenderTextFieldView()
        
        tableView.dataSource = dataSource
        tableView.delegate = tableViewDelegate
        
        view.addSubview(tableView)
        view.addSubview(textFieldView.view)
        view.addSubview(loadingView.view)

    }
    
    func showLoadingView() {
        loadingView.view.alpha = 1
        textFieldView.sendMessageTextField.isEnabled = false
        textFieldView.button.isEnabled = false
    }
    
    func hideLoadingView() {
        loadingView.view.alpha = 0
        textFieldView.sendMessageTextField.isEnabled = true
        textFieldView.button.isEnabled = true
    }
    
    func clearMessageTextField() {
        textFieldView.clear()
    }
    
    var isLoadingViewHidden: Bool {
        return loadingView.view.alpha == 0
    }
    
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
        loadingView.addConstraints()
    }
}
