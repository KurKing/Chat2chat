//
//  DataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Firebase

class DataBase {
    typealias DBConstants = Constants.DataBase
    
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private let userToken: String
    
    private var currentChatId: String
    private var currentDocument: DocumentReference {
        return db
            .collection(DBConstants.chatCollection)
            .document(currentChatId)
    }
    
    private let delegate: DataBaseDelegate
    
    init(delegate: DataBaseDelegate) {
        self.delegate = delegate
        
        if let token = UserDefaults.standard.string(forKey: DBConstants.userToken){
            userToken = token[0..<6]
        } else {
            userToken = UUID().uuidString[0..<6]
            UserDefaults.standard.set(userToken, forKey: DBConstants.userToken)
        }
        
        currentChatId = userToken
        print("User token: \(userToken)")
    }
    
    func startChat(){
        
        db.collection(DBConstants.chatCollection)
            .whereField(DBConstants.isFreeParametr, isEqualTo: true)
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
                            .collection(DBConstants.chatCollection).document(dataBase.currentChatId).updateData([DBConstants.isFreeParametr : false])
                        
                        dataBase.delegate.hideLoadingView()
                        dataBase.sendMessage(
                            Message(text: Constants.Messages.chatStartMessage, fromMe: true))
                        dataBase.addListenerToChat()
                        
                    }
                }
            }
    }
    
    func deleteChat(){
        listener?.remove()
        
        currentDocument
            .collection(DBConstants.messageCollection)
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
        
        db.collection(DBConstants.chatCollection)
            .document(currentChatId)
            .setData([DBConstants.isFreeParametr: true]) {
                if let error = $0 {
                    print(error.localizedDescription)
                }
            }
        
        addListenerToChat()
    }
    
    private func addListenerToChat() {
        
        listener?.remove()
        print("Add listener to chat with id: \(currentChatId)")
        
        listener = db.collection(DBConstants.chatCollection)
            .document(currentChatId)
            .collection(DBConstants.messageCollection)
            .order(by: DBConstants.timeParametr)
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
                            
                            if let text = data[DBConstants.textParametr] as? String,
                               let fromUser = data[DBConstants.userToken] as? String {
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
            .collection(DBConstants.messageCollection)
            .addDocument(data: [
                DBConstants.textParametr : message.text,
                DBConstants.userToken : userToken,
                DBConstants.timeParametr : Date().timeIntervalSince1970
            ])
    }
}

