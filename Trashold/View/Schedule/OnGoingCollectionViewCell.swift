//
//  onGoingCollectionViewCell.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 12/08/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import UIKit

class OnGoingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bookingIdLabel: UILabel!
    
    @IBOutlet weak var navigationDetailView: UIView!
    @IBOutlet weak var navigationIconImageView: UIImageView!
    @IBOutlet weak var wasteBankNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var timeDetailView: UIView!
    @IBOutlet weak var timeIconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var phoneNumber:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
    }
    
    @IBAction func phoneCallClicked(_ sender: Any) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
}
