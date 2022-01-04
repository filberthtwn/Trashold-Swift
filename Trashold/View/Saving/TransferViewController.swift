//
//  TransferViewController.swift
//  Practice
//
//  Created by Marco Jordiansyah on 14/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class TransferViewController: UIViewController {
    var finalBank = ""
    var loginUser = "user1"
    let savingBackendDelegate = SavingViewBackend()
    var agree: Bool = false
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        nameField.placeholder = "Name"
        accountField.placeholder = "Account Number"
        amountField.placeholder = "Amount"
        
        if finalBank == "BCA" {
            bankImage.image = UIImage(named: "bcaBig.png")
        }
        else if finalBank == "Mandiri" {
            bankImage.image = UIImage(named: "mandiriBig.jpg")
        }
        else if finalBank == "BNI" {
            bankImage.image = UIImage(named: "bniBig.png")
        }
        else if finalBank == "Others" {
            bankImage.image = UIImage(named: "visa.png")
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        let name = nameField.text!
        let amount = amountField.text!
        let bank = finalBank
        let accountNumber = accountField.text!
        
        if name != "" && amount != "" && bank != "" && accountNumber != "" {
            if agree == true {
                let amountNumber = Int(amount)!
                savingBackendDelegate.insertWithdraw(loginUser: loginUser, name: name, amount: amountNumber, bank: bank, accountNumber: accountNumber)
                performSegue(withIdentifier: "Submit", sender: self)
            }
            else if agree == false {
                errorLabel.isHidden = false
            }
        }
        else {
            errorLabel.isHidden = false
        }
        
    }
    
    //Calls this function when the tap is recognized.
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func checkboxClicked(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            agree = false
        }
        else {
            sender.isSelected = true
            agree = true
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
