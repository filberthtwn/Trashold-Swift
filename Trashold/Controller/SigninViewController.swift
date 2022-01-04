//
//  SigninViewController.swift
//  Trashold
//
//  Created by Marco Jordiansyah on 16/07/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    let backendDelegate = SignInBackend()
    
    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var usernameFormView: UIView!
    @IBOutlet weak var passwordFormView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // If backButton clicked, change navigationController background color.
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        // Setup your navigation bar
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9999848008, green: 0.8354597092, blue: 0.1511399448, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupViews(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .init(white: 0, alpha: 0)
        self.navigationController?.navigationBar.tintColor = .black
        
        self.tabBarController?.tabBar.isHidden = true
        
        formBackgroundView.layer.cornerRadius = 20
        formBackgroundView.layer.masksToBounds = true
        
        usernameFormView.layer.cornerRadius = 20
        usernameFormView.layer.masksToBounds = true
        
        passwordFormView.layer.cornerRadius = 20
        passwordFormView.layer.masksToBounds = true
        
        signInButton.layer.cornerRadius = 15
        signInButton.layer.masksToBounds = true
        
        self.hideKeyboardWhenTappedAround()
        
        backendDelegate.delegate = self
    }
    
    @IBAction func signInAction(_ sender: Any) {
        if let username = usernameTextField.text{
            if let password = passwordTextField.text{
                backendDelegate.signInProcess(username: username, password: password)
            }
        }
    }
    @IBAction func signUpAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Signup", bundle: Bundle.main).instantiateViewController(withIdentifier: "signUpStoryboard") as? SignupViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
