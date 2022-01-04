//
//  WithdrawViewController.swift
//  Practice
//
//  Created by Marco Jordiansyah on 14/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class WithdrawViewController: UIViewController {

    @IBOutlet weak var othersButton: UIButton!
    @IBOutlet weak var bniButton: UIButton!
    @IBOutlet weak var mandiriButton: UIButton!
    @IBOutlet weak var bcaButton: UIButton!
    @IBOutlet weak var withdrawImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        withdrawImage.image = UIImage(named: "withdraw.png")
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BCA" {
            let vc = segue.destination as! TransferViewController
            vc.finalBank = "BCA"
        }
        else if segue.identifier == "BNI" {
            let vc = segue.destination as! TransferViewController
            vc.finalBank = "BNI"
        }
        else if segue.identifier == "Mandiri" {
            let vc = segue.destination as! TransferViewController
            vc.finalBank = "Mandiri"
        }
        else if segue.identifier == "Others" {
            let vc = segue.destination as! TransferViewController
            vc.finalBank = "Others"
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
