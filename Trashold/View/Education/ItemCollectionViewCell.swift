//
//  ItemCollectionViewCell.swift
//  HomeButton
//
//  Created by Olivia Kwandy on 09/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewLuar: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTrash: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLuar.layer.cornerRadius = 15
        viewLuar.layer.masksToBounds = true
        // Initialization code
        
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
    
    }
    
}
