//
//  DataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Firebase

class DataBase {
    //MARK: - Constants
    private let chatCollection = "Chats"
    private let messageCollection = "messages"
    
    //MARK: - Properties
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let userToken: String
    private let lastChatId = UserDefaults.standard.string(forKey: "lastChatId")
    
    private var currentChatId: String
    
    //MARK: - Init
    init() {
        if let token = UserDefaults.standard.string(forKey: "userToken"){
            userToken = token[0..<4]
        } else {
            userToken = UUID().uuidString[0..<4]
            UserDefaults.standard.set(userToken, forKey: "userToken")
        }
        
        currentChatId = userToken
        
        print("TOKEN: \(userToken)")
    }
    
    //MARK: - startChat
    func startChat(with complition: @escaping (Message)->()){
        
        return
        
        print("Start chat")
        
        if let lastChatId = lastChatId {
            db.collection(chatCollection)
                .document(lastChatId)
                .getDocument { [self] (document, error) in
                    if let document = document, document.exists {
                        addListenerToChat(with: lastChatId, with: complition)
                    } else {
                        findNewChat(with: complition)
                    }
                }
        } else {
            findNewChat(with: complition)
        }
        
    }
    
    //MARK: - createNewChat
    private func createNewChat(with complition: @escaping (Message)->()){
        
        print("Create new chat")
        
        db.collection(chatCollection)
            .document(userToken)
            .setData(["isFree": true]) {
                if let error = $0 {
                    print(error.localizedDescription)
                }
            }
        
        addListenerToChat(with: userToken, with: complition)
    }
    
    //MARK: - findNewChat
    private func findNewChat(with complition: @escaping (Message)->()){
        
        print("Find new chat")
        
        self.db.collection(chatCollection)
            .whereField("isFree", isEqualTo: true)
            .getDocuments { [self] query, error in
                
                guard let query = query else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }
                
                if query.isEmpty {
                    
                    self.createNewChat(with: complition)
                    
                } else {
                    
                    let documents = query.documents
                    let id = documents[Int.random(in: 0..<documents.count)].documentID
                    
                    self.db.collection(chatCollection).document(id).updateData(["isFree" : false])
                    self.addListenerToChat(with: id, with: complition)
                    
                }
            }
    }
    
    //MARK: - addListenerToChat
    private func addListenerToChat(with id: String, with complition: @escaping (Message)->()) {
        
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
                        complition(
                            Message(
                                text: data["text"] as! String,
                                fromMe: data["fromUser"] as! String == self.userToken
                            )
                        )
                    }
                }
            }
    }
    
    //MARK: - sendMessage
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

