//
//  Booking.swift
//  Trashold
//
//  Created by Filbert Hartawan on 20/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation

class Booking{
    let bookingId:String?
    let scheduleId:String?
    let status:Int?
    
    init(bookingId:String?, scheduleId:String, status:Int) {
        self.bookingId = bookingId
        self.scheduleId = scheduleId
        self.status = status
    }
}
