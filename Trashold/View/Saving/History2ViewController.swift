//
//  History2ViewController.swift
//  Practice
//
//  Created by Marco Jordiansyah on 14/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class History2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var statusNotes: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bookingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var finalStatus = ""
    var finalDate = ""
    var finalTime = ""
    var finalBooking = ""
    var finalMoney = ""
    
    var product = ["HVS","Plastic","Bottle","Glass","Cup","Nail","Total"]
    var quantity = ["1 kg","5 kg","2 kg","3 kg","4 kg","1 kg",""]
    var money = ["IDR 50.000","IDR 50.000","IDR 50.000","IDR 50.000","IDR 50.000","IDR 50.000"]
    var quantityText = ["Quantity = ","Quantity = ","Quantity = ","Quantity = ","Quantity = ","Quantity = ",""]
    
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
        
        money.append(finalMoney)
        timeLabel.text = finalTime
        dateLabel.text = finalDate
        bookingLabel.text = finalBooking
        statusLabel.text = finalStatus
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Transaction", for: indexPath) as! TransactionTableViewCell
        
        cell.quantity.text = quantityText[indexPath.row]
        cell.moneyLabel.text = money[indexPath.row]
        cell.quantityLabel.text = quantity[indexPath.row]
        cell.productNameLabel.text = product[indexPath.row]
        
        return cell
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
