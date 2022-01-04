//
//  Trash.swift
//  HomeButton
//
//  Created by Olivia Kwandy on 14/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import Foundation

class TrashInfo{
    var trashTitle:String?
    var trashPrice:String?
    var trashImageName:String?
    
    init(trashTitle:String, trashPrice:String, trashImageName:String) {
        self.trashTitle = trashTitle
        self.trashPrice = trashPrice
        self.trashImageName = trashImageName
    }
}
