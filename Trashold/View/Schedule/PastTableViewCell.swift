//
//  PastTableViewCell.swift
//  Trashold
//
//  Created by Filbert Hartawan on 14/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class PastTableViewCell: UITableViewCell {

    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var wasteBankNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
