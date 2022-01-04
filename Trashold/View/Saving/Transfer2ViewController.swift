//
//  Transfer2ViewController.swift
//  Trashold
//
//  Created by Marco Jordiansyah on 19/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class Transfer2ViewController: UIViewController {

    @IBOutlet weak var bankField: UITextField!
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bankField.placeholder = "Bank"
        nameField.placeholder = "Name"
        accountField.placeholder = "Account Number"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        performSegue(withIdentifier: "Submit", sender: self)
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
