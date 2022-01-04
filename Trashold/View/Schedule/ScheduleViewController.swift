//
//  MyBookingViewController.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 09/08/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var scheduleTableView: UITableView!
    
    var userSchedule:[Schedule] = []
    var onGoingBookingList:[Booking] = []
    var pastBookingList:[Booking] = []
    let scheduleBackendDelegate = ScheduleViewBackend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        fetchAllSchedule()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.viewControllers?[0].viewDidLoad()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    func setupViews(){
        scheduleTableView.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9764705882, alpha: 1)
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        // Register Cell
        scheduleTableView.register(UINib(nibName: "OnGoingTableViewCell", bundle: nil), forCellReuseIdentifier: "onGoingCell")
        scheduleTableView.register(UINib(nibName: "PastTableViewCell", bundle: nil), forCellReuseIdentifier: "pastCell")
        
        // Set delegate inside scheduleBackendDelegate
        scheduleBackendDelegate.delegate = self
        
        setupRefresher()
    }
    
    func setupRefresher(){
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        scheduleTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(refreshControl:UIRefreshControl){
        self.userSchedule.removeAll()
        self.onGoingBookingList.removeAll()
        self.pastBookingList.removeAll()
        self.scheduleTableView.reloadData()
        fetchAllSchedule()
        refreshControl.endRefreshing()
    }
    
    
    func fetchAllSchedule(){
        guard let currentUserId = GlobalVariable.currentUser else{
            return
        }
        scheduleBackendDelegate.fetchAllBookingByUserId(userId: currentUserId) { ( bookingList, error) in
            //Clear all array.
            self.userSchedule.removeAll()
            self.onGoingBookingList.removeAll()
            self.pastBookingList.removeAll()
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            for booking in bookingList{
                if booking.status == 0{
                    self.onGoingBookingList.append(booking)
                }else{
                    self.pastBookingList.append(booking)
                }
            }
            self.scheduleTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "On Going"
        }
        return "Past"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if onGoingBookingList.count == 0 && pastBookingList.count == 0{
//            if section == 0{
//                return 1
//            }
//            else{
//                return 5
//            }
//        }
        
        if section == 0 {
            return onGoingBookingList.count
        }
        return pastBookingList.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
                guard let cell = tableView.cellForRow(at: indexPath) as? OnGoingTableViewCell else{return}
                guard let bookingId = cell.bookingId else{return}
                self.scheduleBackendDelegate.deleteBooking(bookingId: bookingId)
                completionHandler(true)
            }
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
//            swipeConfiguration.performsFirstActionWithFullSwipe = false
            return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Disable swipe action for PAST SECTION
        if indexPath.section == 1{
            return false
        }
        return true
    }
    
    let sectionHeaderTitleList:[String] = ["On Going", "Past"]
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 36))
        headerView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9490196078, alpha: 1)
        
        let headerLabel = UILabel(frame: CGRect(x: 8, y: 0, width: headerView.frame.width, height: 36))
        headerLabel.text = self.sectionHeaderTitleList[section]
        headerLabel.textColor = #colorLiteral(red: 0.4196078431, green: 0.4588235294, blue: 0.4941176471, alpha: 1)
        headerLabel.font = .boldSystemFont(ofSize: 16)
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if onGoingBookingList.count == 0 && pastBookingList.count == 0{
//            if indexPath.section == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "onGoingCell", for: indexPath) as! OnGoingTableViewCell
//                //                isHiddenOnGoingCellContent(cell: cell, isHidden: true)
//                return cell
//            }else{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "pastCell", for: indexPath) as! PastTableViewCell
//                //                isHiddenPastCellContent(cell: cell, isHidden: true)
//                return cell
//            }
//        }
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "onGoingCell", for: indexPath) as! OnGoingTableViewCell
            cell.selectionStyle = .none
            let booking = onGoingBookingList[indexPath.item]
            guard let bookingId = booking.bookingId else{return cell}
            guard let scheduleId = booking.scheduleId else{return cell}
            fetchScheduleByScheduleId(scheduleId: scheduleId) { (schedule, error) in
                self.getWasteBank(wasteBankID: schedule.wasteBankId) { (wasteBank, error) in
                    cell.wasteBankNameLabel.text = wasteBank.name
                    cell.addressLabel.text = wasteBank.address
                    cell.dateLabel.text = schedule.openDate
                    cell.timeLabel.text = schedule.openTime
                    cell.bookingId = bookingId
                    cell.phoneNumber = wasteBank.phoneNumber
                    cell.latitude = wasteBank.latitude
                    cell.longitude = wasteBank.longitude
                    cell.prepareForReuse()
                }
            }
            
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastCell", for: indexPath) as! PastTableViewCell
        cell.selectionStyle = .none
        let booking = pastBookingList[indexPath.item]
        guard let bookingId = booking.bookingId else{return cell}
        guard let scheduleId = booking.scheduleId else{return cell}
        fetchScheduleByScheduleId(scheduleId: scheduleId) { (schedule, error) in
            self.getWasteBank(wasteBankID: schedule.wasteBankId) { (wasteBank, error) in
                cell.bookingIdLabel.text = "Booking ID : \(bookingId)"
                cell.wasteBankNameLabel.text = wasteBank.name
                cell.addressLabel.text = wasteBank.address
                cell.dateLabel.text = schedule.openDate
                cell.timeLabel.text = schedule.openTime
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func fetchScheduleByScheduleId(scheduleId:String, completion:@escaping(Schedule, Error?)->Void){
        scheduleBackendDelegate.getScheduleByScheduleId(scheduleId: scheduleId) { (schedule, error) in
            if let error = error {
                print("Error : \(error)")
                return
            }
            completion(schedule, error)
        }
    }
    
    
    func getWasteBank(wasteBankID:String, completion:@escaping(WasteBank, Error?)->Void){
        scheduleBackendDelegate.getWasteBank(wasteBankId: wasteBankID, completion: { (currentWasteBank, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            completion(currentWasteBank, error)
        })
    }
}
