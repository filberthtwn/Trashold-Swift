//
//  Schedule.swift
//  Trashold
//
//  Created by Filbert Hartawan on 13/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation

class Schedule{
    let scheduleId:String
    let wasteBankId:String
    let openDate:String
    let openTime:String
    
    init(scheduleId:String, wasteBankId:String, openDate:String, openTime:String) {
        self.scheduleId = scheduleId
        self.wasteBankId = wasteBankId
        self.openDate = openDate
        self.openTime = openTime
    }
}
