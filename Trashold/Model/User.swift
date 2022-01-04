//
//  User.swift
//  Trashold
//
//  Created by Marco Jordiansyah on 19/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import Foundation

class User{
    let name:String
    let email:String
    let telephone:String
    let password:String
    
    init(name:String, email:String, telephone:String, password:String) {
        self.name = name
        self.email = email
        self.telephone = telephone
        self.password = password
    }
}
