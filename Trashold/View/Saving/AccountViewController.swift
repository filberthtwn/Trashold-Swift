//
//  AccountViewController.swift
//  Practice
//
//  Created by Marco Jordiansyah on 12/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var savingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var status = ""
    var booking = ""
    var money = ""
    var date = ""
    var time = ""
    var loginUser = "user1"
    var accountNumber = ""
    var bank = ""
    var name = ""
    var savingBackendDelegate = SavingViewBackend()
    
    let currencyFormatter = NumberFormatter()
    
    var bookingID = [String]()
    var titleLabel = [String]()
    var dateLabel = [String]()
    var statusLabel = [String]()
    var timeLabel = [String]()
    var pictures = [String]()
    var bankArr = [String]()
    var accountNumberArr = [String]()
    var nameArr = [String]()
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        //refresh table view when opening first time
        self.refreshData()
        
        //refresh table view when user drag to refresh
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        savingBackendDelegate.fetchWithdraw(loginUser: loginUser) { (historyList, error) in
            if self.bookingID != [] {
                self.bookingID.removeAll()
                self.titleLabel.removeAll()
                self.dateLabel.removeAll()
                self.statusLabel.removeAll()
                self.timeLabel.removeAll()
                self.pictures.removeAll()
                self.bankArr.removeAll()
                self.accountNumberArr.removeAll()
                self.nameArr.removeAll()
            }
            
            for i in 0...historyList.count-1 {
                self.bookingID.insert(historyList[i].id, at: i)
                self.titleLabel.insert(self.currencyFormatter.string(from: NSNumber(value: historyList[i].amount))!, at: i)
                self.dateLabel.insert(historyList[i].date, at: i)
                self.statusLabel.insert(historyList[i].status, at: i)
                self.timeLabel.insert(historyList[i].time, at: i)
                self.pictures.insert(historyList[i].status.lowercased(), at: i)
                self.bankArr.insert(historyList[i].bank, at: i)
                self.accountNumberArr.insert(historyList[i].accountNumber, at: i)
                self.nameArr.insert(historyList[i].name, at: i)
                self.tableView.reloadData()
                //                self.tableView.beginUpdates()
                //                self.tableView.insertRows(at: [indexPath], with: .automatic)
                //                self.tableView.endUpdates()
            }
            
            self.refreshControl.endRefreshing()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Withdraw", for: indexPath) as! AccountTableViewCell
        //        print(indexPath.row)
        cell.titleLabel.text = titleLabel[indexPath.row]
        cell.dateLabel.text = dateLabel[indexPath.row]
        cell.statusLabel.text = statusLabel[indexPath.row]
        cell.timeLabel.text = timeLabel[indexPath.row]
        cell.statusImage.image = UIImage(named: pictures[indexPath.row] + ".png")
        cell.statusImage.contentMode = .scaleToFill
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.booking = bookingID[indexPath.row]
        self.status = statusLabel[indexPath.row]
        self.money = titleLabel[indexPath.row]
        self.date = dateLabel[indexPath.row]
        self.time = timeLabel[indexPath.row]
        self.accountNumber = accountNumberArr[indexPath.row]
        self.bank = bankArr[indexPath.row]
        self.name = nameArr[indexPath.row]
        
        if titleLabel[indexPath.row].prefix(1) == "+" {
            performSegue(withIdentifier: "HistoryPlus", sender: self)
        }
            //        if titleLabel[indexPath.row].prefix(1) == "-"
        else {
            performSegue(withIdentifier: "HistoryMinus", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryMinus" {
            let vc = segue.destination as! HistoryViewController
            vc.finalStatus = self.status
            vc.finalBooking = self.booking
            vc.finalMoney = self.money
            vc.finalDate = self.date
            vc.finalTime = self.time
            vc.finalName = self.name
            vc.finalBank = self.bank
            vc.finalAccountNumber = self.accountNumber
        }
        else if segue.identifier == "HistoryPlus" {
            let vc = segue.destination as! History2ViewController
            vc.finalStatus = self.status
            vc.finalBooking = self.booking
            vc.finalMoney = self.money
            vc.finalDate = self.date
            vc.finalTime = self.time
        }
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
