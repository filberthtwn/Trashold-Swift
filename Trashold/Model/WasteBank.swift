//
//  WasteBank.swift
//  Trashold
//
//  Created by Filbert Hartawan on 20/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation

class WasteBank{
    
    let wasteBankId:String?
    let name:String?
    let address:String?
    let phoneNumber:String?
    let longitude:Double?
    let latitude:Double?
    
    init(wasteBankId:String, name:String, address:String, phoneNumber:String, longitude:Double, latitude:Double){
       self.wasteBankId = wasteBankId
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.longitude = longitude
        self.latitude = latitude
    }
}


