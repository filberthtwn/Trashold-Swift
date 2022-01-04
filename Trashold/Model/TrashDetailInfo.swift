//
//  TrashDetailInfo.swift
//  HomeButton
//
//  Created by Olivia Kwandy on 16/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import Foundation

class TrashDetailInfo{
    var trashDetailTitle:String?
    var trashDetailSubtitle:String?
    var trashDetailPrice:String?
    var trashDetailImageName:String?
    
    init(trashDetailTitle:String,trashDetailSubtitle:String, trashDetailPrice:String, trashDetailImageName:String) {
        self.trashDetailTitle = trashDetailTitle
        self.trashDetailSubtitle = trashDetailSubtitle
        self.trashDetailPrice = trashDetailPrice
        self.trashDetailImageName = trashDetailImageName
    }
}
