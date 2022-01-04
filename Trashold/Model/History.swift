//
//  History.swift
//  Trashold
//
//  Created by Marco Jordiansyah on 21/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation

class History{
    let id:String
    let name:String
    let status:String
    let date:String
    let time:String
    let amount:Int
    let accountNumber:String
    let bank:String
    
    
    init(id:String, name:String, status:String, date:String, time:String, amount:Int, accountNumber:String, bank:String) {
        self.id = id
        self.name = name
        self.status = status
        self.date = date
        self.time = time
        self.amount = amount
        self.accountNumber  = accountNumber
        self.bank = bank
    }
}
