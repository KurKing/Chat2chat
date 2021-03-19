//
//  DataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Firebase

class DataBase {
    let constants = Constants.DataBase.self
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let userToken: String
    
    private var currentChatId: String
    private var currentDocument: DocumentReference {
        return db
            .collection(constants.chatCollection)
            .document(currentChatId)
    }
    
    private let delegate: DataBaseDelegate
    
    init(delegate: DataBaseDelegate) {
        self.delegate = delegate
        
        if let token = UserDefaults.standard.string(forKey: constants.userToken){
            userToken = token[0..<6]
        } else {
            userToken = UUID().uuidString[0..<6]
            UserDefaults.standard.set(userToken, forKey: constants.userToken)
        }
        
        currentChatId = userToken
        print("User token: \(userToken)")
    }
    
    func startChat(){
        
        db.collection(constants.chatCollection)
            .whereField("isFree", isEqualTo: true)
            .getDocuments { [weak self] query, error in
                
                if let dataBase = self {
                    guard let query = query else {
                        return
                    }
                    
                    if query.isEmpty {
                        
                        dataBase.createNewChat()
                        
                    } else {
                        
                        dataBase.currentChatId = query.documents[Int.random(in: 0..<query.documents.count)].documentID
                        
                        dataBase.db
                            .collection(dataBase.constants.chatCollection).document(dataBase.currentChatId).updateData(["isFree" : false])
                        
                        dataBase.delegate.hideLoadingView()
                        dataBase.sendMessage(
                            Message(text: "User \(dataBase.userToken) connected", fromMe: true))
                        dataBase.addListenerToChat()
                        
                    }
                }
            }
    }
    
    func deleteChat(){
        listener?.remove()
        
        currentDocument
            .collection(constants.messageCollection)
            .getDocuments { (query, error) in
                if let query = query {
                    for i in query.documents {
                        i.reference.delete()
                    }
                }
            }
        
        currentDocument
            .delete()
    }
    
    private func createNewChat(){
        
        currentChatId = UUID().uuidString[0..<6]
        
        db.collection(constants.chatCollection)
            .document(currentChatId)
            .setData(["isFree": true]) {
                if let error = $0 {
                    print(error.localizedDescription)
                }
            }
        
        addListenerToChat()
    }
    
    private func addListenerToChat() {
        
        listener?.remove()
        print("Add listener to chat with id: \(currentChatId)")
        
        listener = db.collection(constants.chatCollection)
            .document(currentChatId)
            .collection(constants.messageCollection)
            .order(by: "time")
            .addSnapshotListener { [weak self] query, error in
                
                if let dataBase = self {
                    
                    guard let query = query else {
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        return
                    }
                    
                    query.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            let data = diff.document.data()
                            
                            if let text = data["text"] as? String,
                               let fromUser = data["fromUser"] as? String {
                                dataBase.delegate
                                    .addMessage(message:Message(text: text, fromMe: fromUser == dataBase.userToken))
                            }
                            
                        } else if (diff.type == .removed) {
                            dataBase.listener?.remove()
                            dataBase.delegate.clearMessages()
                        }
                    }
                    
                }
                
            }
    }
    
    func sendMessage(_ message: Message){
        currentDocument
            .collection(constants.messageCollection)
            .addDocument(data: [
                "text" : message.text,
                "fromUser": userToken,
                "time" : Date().timeIntervalSince1970
            ])
    }
}

