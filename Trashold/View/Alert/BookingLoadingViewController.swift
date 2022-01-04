//
//  BookingLoadingViewController.swift
//  Trashold
//
//  Created by Filbert Hartawan on 23/08/19.
//  Copyright © 2019 Marco Jordiansyah. All rights reserved.
//

import UIKit

class BookingLoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingViewBg: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var doneImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addLoadingObserver()

    }
    
    func addLoadingObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "loadingDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupViewsToDone), name: NSNotification.Name(rawValue: "loadingDone"), object: nil)
    }
    
    @objc func setupViewsToDone(){
        activityIndicator.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.doneImageView.alpha = 1
            self.view.layoutIfNeeded()
        }
        loadingLabel.text = "DONE"
    }
    
    func setupViews(){
        loadingViewBg.layer.cornerRadius = 20
        loadingViewBg.layer.masksToBounds = true
    }
}
