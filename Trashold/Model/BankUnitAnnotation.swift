//
//  BankUnit.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 08/08/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import Foundation
import MapKit

class BankUnitAnnotation: NSObject, MKAnnotation {
    let scheduleId:String?
    let wasteBankId:String?
    let title: String?
    let address:String!
    var openDate:String!
    let openTime:String
    let type:String
    let coordinate: CLLocationCoordinate2D
    
    init(scheduleId:String, wasteBankId:String, title:String, address:String,openDate:String,openTime:String, type:String,  coordinate:CLLocationCoordinate2D) {
        self.scheduleId = scheduleId
        self.wasteBankId = wasteBankId
        self.title = title
        self.address = address
        self.openDate = openDate
        self.openTime = openTime
        self.type = type
        self.coordinate = coordinate
        
        super.init()
    }
}
