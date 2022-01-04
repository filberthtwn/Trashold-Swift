//
//  ProfileViewController.swift
//  Practice
//
//  Created by Marco Jordiansyah on 13/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    let savingBackendDelegate = SavingViewBackend()
    var loginUser = "user1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        savingBackendDelegate.fetchUser(loginUser: loginUser) { (userList, error) in
            self.nameField.text = userList[0].name
            self.emailField.text = userList[0].email
            self.passwordField.text = userList[0].password
            self.phoneField.text = userList[0].telephone
        }
        
        profileImage.image = UIImage(named: "profile.png")
        
        // Do any additional setup after loading the view.
    }

    @IBAction func updateClicked(_ sender: Any) {
        let name = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        let phone = phoneField.text!
        savingBackendDelegate.updateUser(loginUser: loginUser, name: name, email: email, password: password, phone: phone)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Calls this function when the tap is recognized.
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
