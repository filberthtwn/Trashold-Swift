//
//  OnGoingTableViewCell.swift
//  Trashold
//
//  Created by Filbert Hartawan on 14/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class OnGoingTableViewCell: UITableViewCell {

    @IBOutlet weak var bookingIdLabel: UILabel!
    @IBOutlet weak var wasteBankNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    var bookingId:String?
    var phoneNumber:String?
    var latitude:Double?
    var longitude:Double?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews(){
        guard let bookingId = self.bookingId else{return}
        bookingIdLabel.text = "Booking ID: \(bookingId)"
    }
    
    override func prepareForReuse() {
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func navigationAction(_ sender: Any) {
        guard let latitude = self.latitude else{return}
        guard let longitude = self.longitude else{return}

        let directionsURL = "http://maps.apple.com/?saddr=&daddr=\(latitude),\(longitude))"
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func callAction(_ sender: Any) {
        guard let phoneNumber = self.phoneNumber else{return}
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
}
