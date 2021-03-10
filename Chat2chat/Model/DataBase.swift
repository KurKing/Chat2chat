//
//  DataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Firebase

class DataBase {

    private let chatCollection = "Chats"
    private let messageCollection = "messages"

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let userToken: String
    private let lastChatId = UserDefaults.standard.string(forKey: "lastChatId")
    
    private var currentChatId: String
    
    private let addMessageComplition: ((Message)->())
    private let delegate: ClearMessagesDelegate

    init(delegate: ClearMessagesDelegate, complition: @escaping ((Message)->())) {
        self.delegate = delegate
        
        addMessageComplition = complition
        
        if let token = UserDefaults.standard.string(forKey: "userToken"){
            userToken = token[0..<4]
        } else {
            userToken = UUID().uuidString[0..<4]
            UserDefaults.standard.set(userToken, forKey: "userToken")
        }
        
        currentChatId = userToken
        print(userToken)
    }

    func startChat(){
            
        if let lastChatId = lastChatId {
            db.collection(chatCollection)
                .document(lastChatId)
                .getDocument { [self] (document, error) in
                    if let document = document, document.exists {
                        addListenerToChat(id: lastChatId)
                    } else {
                        findNewChat()
                    }
                }
        } else {
            findNewChat()
        }
        
    }
    
    func deleteChat(){
        db.collection(chatCollection)
            .document(currentChatId)
            .collection(messageCollection)
            .getDocuments { (query, error) in
                if let query = query {
                    for i in query.documents {
                        i.reference.delete()
                    }
                }
            }
            
        db.collection(chatCollection)
            .document(currentChatId)
            .delete()
        listener?.remove()
        listener = nil
    }

    private func createNewChat(){
        
        db.collection(chatCollection)
            .document(userToken)
            .setData(["isFree": true]) {
                if let error = $0 {
                    print(error.localizedDescription)
                }
            }
        
        addListenerToChat(id: userToken)
    }

    private func findNewChat(){
        
        self.db.collection(chatCollection)
            .whereField("isFree", isEqualTo: true)
            .getDocuments { [self] query, error in
                
                guard let query = query else {
                    return
                }
                
                if query.isEmpty {
    
                    self.createNewChat()
                    
                } else {
                    
                    let documents = query.documents
                    let id = documents[Int.random(in: 0..<documents.count)].documentID
                    
                    self.db.collection(chatCollection).document(id).updateData(["isFree" : false])
                    self.addListenerToChat(id: id)
                    
                }
            }
    }

    private func addListenerToChat(id: String) {
        
        listener?.remove()
        
        UserDefaults.standard.set(id, forKey: "lastChatId")
        
        print("Add listener to chat with id: \(id)")
        currentChatId = id
        sendMessage(Message(text: "User \(userToken) connected", fromMe: true))
        
        listener = db.collection(chatCollection)
            .document(id)
            .collection(messageCollection)
            .order(by: "time")
            .addSnapshotListener { [self] query, error in
                
                guard let query = query else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }
                
                query.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let data = diff.document.data()
                        addMessageComplition(
                            Message(
                                text: data["text"] as! String,
                                fromMe: data["fromUser"] as! String == self.userToken
                            )
                        )
                    } else if (diff.type == .removed){
                        deleteChat()
                        delegate.clearMessages()
                        startChat()
                    }
                }
            }
    }
    
    
    
    func sendMessage(_ message: Message){
        db.collection(chatCollection)
            .document(currentChatId)
            .collection(messageCollection)
            .addDocument(data: [
                "text" : message.text,
                "fromUser": userToken,
                "time" : Date().timeIntervalSince1970
            ])
    }
}

