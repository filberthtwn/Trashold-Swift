//
//  PastCollectionViewCell.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 12/08/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import UIKit

class PastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pastContentView: UIView!
    @IBOutlet weak var completedIconImageView: UIImageView!
    @IBOutlet weak var wasteBankNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
