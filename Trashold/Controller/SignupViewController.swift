//
//  SignupViewController.swift
//  Trashold
//
//  Created by Marco Jordiansyah on 16/07/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        setupViews()
        
    }
    
    func setupViews(){
        formBackgroundView.layer.cornerRadius = 20
        formBackgroundView.layer.masksToBounds = true
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.masksToBounds = true
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent is MapViewController {
            self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999848008, green: 0.8354597092, blue: 0.1511399448, alpha: 1)
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if fullNameTextField.text != "" && phoneNumberTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != ""{
            let db = Firestore.firestore()
            var userRef: DocumentReference? = nil
            userRef = db.collection("users").addDocument(data: [
                "name": self.fullNameTextField.text!,
                "phoneNumber": self.phoneNumberTextField.text!,
                "email": self.emailTextField.text!,
                "password": self.passwordTextField.text!
            ]){ err in
                if let err = err {
                    print(err)
                }else{
                    GlobalVariable.currentUser = userRef?.documentID
                    self.navigationController!.popToRootViewController(animated: true)
                }
            }
            
        }
        else {
            print("Data is not filled complete!")
        }
    }
}
