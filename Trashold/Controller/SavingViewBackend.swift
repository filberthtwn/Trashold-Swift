//
//  SavingViewBackend.swift
//  Trashold
//
//  Created by Marco Jordiansyah on 19/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation
import Firebase

class SavingViewBackend {
    var delegate: ProfileViewController?
    
    func fetchUser(loginUser: String, completion:@escaping([User], Error?) -> Void) {
        var userList:[User] = []
        
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(loginUser)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userList.removeAll()
                
                let name = document.get("name") as! String
                let email = document.get("email") as! String
                let telephone = document.get("telephone") as! String
                let password = document.get("password") as! String
                
                let user = User(name: name, email: email, telephone: telephone, password: password)
                
                userList.append(user)
            } else {
                print("Document does not exist")
            }
            completion(userList, nil)
        }
        
    }
    
    func fetchWithdraw(loginUser: String, completion:@escaping([History], Error?) -> Void) {
        var historyList:[History] = []
        
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(loginUser).collection("withdraw").order(by: "timestamp",descending: true)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                historyList.removeAll()
                
                for document in querySnapshot!.documents {
                    let id = document.documentID
                    let name = document.get("name") as! String
                    let status = document.get("status")! as! String
                    let date = document.get("date") as! String
                    let time = document.get("time") as! String
                    let amount = document.get("amount") as! Int
                    let accountNumber = document.get("accountNumber") as! String
                    let bank = document.get("bank") as! String
                    
                    let history = History(id: id, name: name, status: status, date: date, time: time, amount: amount, accountNumber: accountNumber, bank: bank)
                    
                    historyList.append(history)
                }
            }
            completion(historyList, nil)
        }
    }
    
    func updateUser(loginUser: String,name: String, email: String,password: String,phone: String) -> Void {
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(loginUser)
        docRef.setData([
            "name": name,
            "email": email,
            "password": password,
            "telephone": phone
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func insertWithdraw(loginUser: String,name: String,amount: Int, bank: String,accountNumber: String) -> Void {
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let db = Firestore.firestore()
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        let docRef = db.collection("users").document(loginUser).collection("withdraw").document()
        docRef.setData([
            "name" : name,
            "amount": amount,
            "bank": bank,
            "accountNumber": accountNumber,
            "status" : "Pending",
            "date": "\(day)-\(month)-\(year)",
            "time" : "\(hour):\(minute)",
            "timestamp" : FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
