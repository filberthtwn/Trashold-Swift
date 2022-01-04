//
//  SignInBackend.swift
//  Trashold
//
//  Created by Filbert Hartawan on 17/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation
import Firebase

class SignInBackend{
    var delegate:SigninViewController?
    
    func signInProcess(username:String, password:String){
        
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users")
        
        userRef.addSnapshotListener {(snapshot, error) in
            if let error = error{
                print(error)
                return
            }else{
                for document in snapshot!.documents{
                    let getEmail = document.get("email") as! String
                    let getPassword = document.get("password") as! String
                    
                    if username.uppercased() == getEmail.uppercased(){
                        if password == getPassword{
                            UserDefaults.standard.set(document.documentID, forKey: "userId")
                            GlobalVariable.currentUser = UserDefaults.standard.string(forKey: "userId")
                            self.delegate?.navigationController?.popViewController(animated: true)
                        }else{
                            print("Username/ password incorrect")
                        }
                    }
                }
            }
        }
    }
}
