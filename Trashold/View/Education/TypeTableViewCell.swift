//
//  TypeTableViewCell.swift
//  HomeButton
//
//  Created by Olivia Kwandy on 13/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import UIKit

class TypeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageType: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        imageType.layer.cornerRadius = 20
        
        imageType.layer.masksToBounds = true
        // Configure the view for the selected state
        
//        imageType.layer.shadowOffset = CGSize(width: 0, height: 1)
//        imageType.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        imageType.layer.shadowRadius = 2
//        imageType.layer.shadowOpacity = 1
//        imageType.clipsToBounds = true
//        imageType.layer.masksToBounds = true
    }
    
}
