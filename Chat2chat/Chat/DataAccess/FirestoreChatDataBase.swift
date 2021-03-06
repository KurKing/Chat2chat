//
//  FirestoreChatDataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Firebase

class FirestoreChatDataBase: ChatDataBase {
    typealias DBConstants = Constants.DataBase
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    func startChat(delegate: ChatDataBaseDelegate, userLogin: String) {
        db.collection(DBConstants.chatCollection)
            .whereField(DBConstants.isFreeParametr, isEqualTo: true)
            .whereField(DBConstants.user1, isNotEqualTo: userLogin)
            .limit(to: 10)
            .getDocuments { [weak self] query, error in
                if let self = self {
                    
                    guard let query = query else {
                        return
                    }
                    
                    if query.isEmpty {
                        //create new chat
                        let chatId = UUID().uuidString
                        self.db.collection(DBConstants.chatCollection)
                            .document(chatId)
                            .setData([
                                DBConstants.isFreeParametr: true,
                                DBConstants.user1: userLogin,
                                DBConstants.user2: "-",
                                DBConstants.timeParametr: Date().timeIntervalSince1970
                            ])
                        delegate.chatId = chatId
                        print("Create new chat with id: \(chatId)")
                        self.addListenerToChat(delegate: delegate, chatId: chatId)

                        
                    } else {
                        //add listener to existing one
                        let chatId = query.documents[Int.random(in: 0..<query.documents.count)].documentID
                        delegate.chatId = chatId
                        
                        self.db.collection(DBConstants.chatCollection)
                            .document(chatId)
                            .updateData([
                                DBConstants.isFreeParametr : false,
                                DBConstants.user2: userLogin
                            ])
                        
                        self.sendMessage(message:
                                            MessageDBEntity(text: Constants.Messages.chatStartMessage, time: Date().timeIntervalSince1970, fromUser: userLogin),
                                         chatId: chatId)
                        self.addListenerToChat(delegate: delegate, chatId: chatId)
                    }
                }
            }
    }
    
    func endChat(delegate: ChatDataBaseDelegate, chatId: String) {
        listener?.remove()
        
        db.collection(DBConstants.chatCollection)
            .document(chatId)
            .collection(DBConstants.messageCollection)
            .getDocuments { (query, error) in
                if let query = query {
                    for i in query.documents {
                        i.reference.delete()
                    }
                }
            }
        
        db.collection(DBConstants.chatCollection)
            .document(chatId)
            .delete()
    }
    
    func sendMessage(message: MessageDBEntity, chatId: String) {
        db.collection(DBConstants.chatCollection)
            .document(chatId)
            .collection(DBConstants.messageCollection)
            .addDocument(data: [
                DBConstants.textParametr : message.text,
                DBConstants.userToken : message.fromUser,
                DBConstants.timeParametr : message.time
            ])
    }
    
    func getName(login: String, complition: @escaping (String) -> ()) {
        db.collection(DBConstants.userCollection)
            .document(login)
            .getDocument { query, error in
                if let query = query, let name = query.get(DBConstants.userName) as? String {
                    complition(name)
                }
            }
    }
    
    func getChatInfo(chatId: String, complition: @escaping ([String : Any]) -> ()) {
        db.collection(DBConstants.chatCollection)
            .document(chatId)
            .getDocument { query, error in
                if let query = query, let data = query.data() {
                    complition(data)
                }
            }
    }
    
    private func addListenerToChat(delegate: ChatDataBaseDelegate, chatId: String) {
        listener?.remove()
        print("Add listener to chat with id: \(chatId)")
        
        listener = db.collection(DBConstants.chatCollection)
            .document(chatId)
            .collection(DBConstants.messageCollection)
            .order(by: DBConstants.timeParametr)
            .addSnapshotListener { [weak self] query, error in
                
                if let self = self {
                    
                    guard let query = query else {
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        return
                    }
                    
                    query.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            if let message = self.getMessageEntityFromDocument(data: diff.document.data()) {
                                delegate.addMessage(message: message)
                            }
                        } else if (diff.type == .removed) {
                            self.listener?.remove()
                            delegate.clearMessages()
                        }
                    }
                }
            }
    }
    
    private func getMessageEntityFromDocument(data: [String:Any]) -> MessageDBEntity? {
        guard let text = data["text"] as? String,
              let time = data["time"] as? Double,
              let userToken = data["userToken"] as? String
        else { 
            return nil
        }
        return MessageDBEntity(text: text, time: time, fromUser: userToken)
    }
    
}

