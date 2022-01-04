//
//  ScheduleViewBackend.swift
//  Trashold
//
//  Created by Filbert Hartawan on 13/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation
import Firebase

class ScheduleViewBackend{
    var delegate:ScheduleViewController?
    
    // Completion paramater for sync.
    func fetchAllBookingByUserId(userId:String, completion:@escaping([Booking], Error?)->Void){
        // [Error Handler] Default app has already been configured.
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        let db = Firestore.firestore()
        
        
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let userRef = db.collection("users").document(userId).collection("booking")
        
        userRef.addSnapshotListener {(documentSnapshot, error) in
            if let error = error{
                print("Error : \(error)")
                return
            }else{
                // Clear scheduleList
                //                scheduleList.removeAll()
                
                self.delegate?.userSchedule.removeAll()
                self.delegate?.onGoingBookingList.removeAll()
                self.delegate?.pastBookingList.removeAll()
                self.delegate?.scheduleTableView.reloadData()
                
                var bookingList:[Booking] = []
                
                guard let snapshot = documentSnapshot else{return}
                for document in snapshot.documents{
                    let bookingId = document.documentID
                    guard let scheduleId = document.get("scheduleId") as? String else {return}
                    guard let status = document.get("status") as? Int else{return}
                    let booking = Booking(bookingId: bookingId, scheduleId: scheduleId, status: status)
                    bookingList.append(booking)
                }
                completion(bookingList, error)
            }
        }
    }
    
    func getScheduleByScheduleId(scheduleId:String,completion:@escaping(Schedule, Error?)->Void){
        let db = Firestore.firestore()
        
        let scheduleReff = db.collection("schedule")
        scheduleReff.getDocuments { (documentSnapshot, error) in
            guard let snapshot = documentSnapshot else{return}
            for document in snapshot.documents{
                if document.documentID == scheduleId{
                    guard let wasteBankId = document.get("wasteBankId") as? String else{return}
                    guard let openDate = document.get("openDate") as? String else{return}
                    guard let openTime = document.get("openTime") as? String else{return}
                    let schedule = Schedule(scheduleId: document.documentID, wasteBankId: wasteBankId, openDate: openDate, openTime: openTime)
                    completion(schedule,error)
                }
            }
        }
    }
    
    func fetchAllSchedule(completion:@escaping([Schedule], Error?)->Void){
        var scheduleList:[Schedule] = []
        // [Error Handler] Default app has alreafetchAllScheduleerId
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("schedule")
        
        userRef.addSnapshotListener {(snapshot, error) in
            if let error = error{
                completion(scheduleList, error)
                return
            }else{
                for document in snapshot!.documents{
                    // Fetch schedule field
                    let wasteBankId = document.get("wasteBankId") as! String
                    let openDate = document.get("openDate") as! String
                    let openTime = document.get("openTime") as! String
                    
                    // Create schedule object model.
                    let schedule = Schedule(scheduleId: document.documentID, wasteBankId: wasteBankId, openDate: openDate, openTime: openTime)
                    
                    // Insert schedule object into array
                    scheduleList.append(schedule)
                }
            }
            completion(scheduleList, nil)
        }
    }
    
    func getWasteBank(wasteBankId:String?, completion:@escaping(WasteBank, Error?)->Void){
        var wasteBank:WasteBank?
        // [Error Handler] Default app has already been configured.
        if (FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let db = Firestore.firestore()
        let userRef = db.collection("wasteBank")
        
        userRef.addSnapshotListener {(snapshot, error) in
            if let error = error{
                completion(wasteBank!, error)
                return
            }else{
                for document in snapshot!.documents{
                    // Fetch schedule field
                    if document.documentID == wasteBankId{
                        let name = document.get("name") as! String
                        let address = document.get("address") as! String
                        let phoneNumber = document.get("phoneNumber") as! String
                        let longitude = (document.get("longitude") as! NSString).doubleValue
                        let latitude = (document.get("latitude") as! NSString).doubleValue
                        
                        // Create schedule object model.
                        wasteBank = WasteBank(wasteBankId: document.documentID, name: name, address: address, phoneNumber: phoneNumber, longitude: longitude, latitude: latitude)
                        break
                    }
                }
            }
            completion(wasteBank!, nil)
        }
    }
    
    func deleteBooking(bookingId:String){
        let db = Firestore.firestore()
        guard let currentUserId = GlobalVariable.currentUser else{return}
        let bookingRef = db.collection("users").document(currentUserId).collection("booking").document(bookingId)
        bookingRef.delete(){ err in
            if let err = err{
                print("Error removing document \(err)")
            }else{
                print("Document successfully removed!")
            }
        }
//        self.delegate?.userSchedule.removeAll()
//        self.delegate?.onGoingBookingList.removeAll()
//        self.delegate?.pastBookingList.removeAll()
        self.delegate?.scheduleTableView.reloadData()
    }
}

