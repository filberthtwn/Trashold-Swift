//
//  ViewController.swift
//  Slidedemo
//
//  Created by Olivia Kwandy on 05/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import UIKit

struct GlobalVariable {
    static var currentUser = UserDefaults.standard.string(forKey: "userId")
}


class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupViews()
    }
    
    func setupViews(){
        getStartedButton.layer.cornerRadius = 15
        getStartedButton.layer.masksToBounds = true
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        performSegue(withIdentifier: "mainSegueIdentifier", sender: self)
    }
}

extension OnBoardingViewController: UIScrollViewDelegate {
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calculate the page index
        let pageIndex = Int(scrollView.contentOffset.x/375)
//        set the page index
         pageControl.currentPage = pageIndex
        if pageIndex == 3 {
            getStartedButton.isHidden = false
        }
    }
}

