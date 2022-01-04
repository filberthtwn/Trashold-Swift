//
//  MapViewBackend.swift
//  Trashold
//
//  Created by Filbert Hartawan on 12/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation
import UIKit
import Firebase

//extension ABC{

//}

class MapViewBackend{
    
    var delegate:MapViewController?
    
    func insertSchedule(scheduleId:String) {
        self.delegate?.showLoadingScreen()

        // [Error Handler] Default app has already been configured.
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        let db = Firestore.firestore()
        
        guard let currentUserId = GlobalVariable.currentUser else{
            
            self.delegate?.dismiss(animated: true, completion: {
                
                let vc = UIStoryboard.init(name: "Signin", bundle: Bundle.main).instantiateViewController(withIdentifier: "signInSegue") as? SigninViewController
                self.delegate?.navigationController?.pushViewController(vc!, animated: true)
            })            
            return
        }
        
        let userRef = db.collection("users").document(currentUserId).collection("booking")
        userRef.getDocuments { (documentSnapshot, error) in
            
            guard let snapshot = documentSnapshot else{return}
            let totalBooking = String(format: "%03d", snapshot.documents.count+1)
            
            
            userRef.document("B\(totalBooking)").setData([
                "scheduleId": scheduleId,
                "status": 0
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadingDone"), object: nil, userInfo: nil)
                    let delayTime = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: delayTime){
                        self.delegate?.dismiss(animated: true, completion: nil)
                        self.delegate?.tabBarController?.selectedIndex = 1
                        print("Document successfully written!")
                    }
                    
                    
                    
                }
            }
        }
    }
    
    func fetchWasteBankById(wasteBankID:String, completion:@escaping(WasteBank, Error?)->Void){
        // [Error Handler] Default app has already been configured.
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let db = Firestore.firestore()
        let userRef = db.collection("wasteBank").document(wasteBankID)
        
        userRef.addSnapshotListener {(documentSnapshot, error) in
            
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            guard let name = data["name"] as? String else{
                return
            }
            guard let address = data["address"] as? String else{
                return
            }
            guard let phoneNumber = data["phoneNumber"] as? String else{
                return
            }
            guard let longitude = Double(data["longitude"] as! String) else{
                return
            }
            guard let latitude = Double(data["latitude"] as! String) else{
                return
            }
            
            // Create schedule object model.
            let wasteBank = WasteBank(wasteBankId:document.documentID, name: name, address: address, phoneNumber: phoneNumber, longitude: longitude, latitude: latitude)
            completion(wasteBank, nil)
        }
    }
}

