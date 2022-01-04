//
//  ConfirmationViewController.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 06/08/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    var delegate:InformationViewDelegate?
    var wasteBankId:String?
    var scheduleId:String?
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        submitButton.layer.cornerRadius = 5
    }
    
    @IBAction func submitAction(_ sender: Any) {
        guard let scheduleId = self.scheduleId else{
            return
        }
        
        delegate?.bookingProcess(scheduleId:scheduleId, wasteBankId: wasteBankId!, namaBankUnit: titleLabel.text!, address: addressLabel.text!, openDate: dateLabel.text!, openTime: timeLabel.text!, status: 0)
    }
}
