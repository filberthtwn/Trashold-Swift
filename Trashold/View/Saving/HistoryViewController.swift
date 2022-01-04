//
//  HistoryViewController.swift
//  Practice
//
//  Created by Marco Jordiansyah on 14/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var statusNotes: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bookingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    var finalStatus = ""
    var finalDate = ""
    var finalTime = ""
    var finalBooking = ""
    var finalMoney = ""
    var finalBank = ""
    var finalAccountNumber = ""
    var finalName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if finalStatus == "Pending" {
            statusImage.image = UIImage(named: "pending.png")
            statusNotes.text = "Your transaction still on progress."
        }
        else if finalStatus == "Completed" {
            statusImage.image = UIImage(named: "completed.png")
            statusNotes.text = "The payment automatically added to your saving."
        }
        
        statusLabel.text = finalStatus
        dateLabel.text = finalDate
        timeLabel.text = finalTime
        bookingLabel.text = finalBooking
        moneyLabel.text = finalMoney
        bankLabel.text = finalBank
        nameLabel.text = finalName
        phoneLabel.text = finalAccountNumber
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
