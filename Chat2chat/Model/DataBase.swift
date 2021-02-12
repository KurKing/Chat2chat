//
//  DataBase.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Firebase

class DataBase {
    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    private var newToken: String {
        return UUID().uuidString
    }
    
    func startChat(with complition: @escaping (Message)->()){
        db.collection("Chats")
            .document("2sOyMheorNtHdouVLn2S")
            .collection("messanges")
            .order(by: "time")
            .addSnapshotListener { query, error in

                guard let query = query else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }

                query.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let data = diff.document.data()
                        complition(Message(text: data["text"]as!String, fromMe: data["fromMe"]as!Bool))
                    }
                }
            }
    }
}

