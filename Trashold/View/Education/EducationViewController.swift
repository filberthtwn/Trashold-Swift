//
//  ViewController.swift
//  HomeButton
//
//  Created by Olivia Kwandy on 09/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import UIKit

class EducationViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // kalo ga ada protocol di atas yang private func error
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var listOfTrashCategory: [String] =  ["Plastic","Glass","Paper",
                                          "Metal",
                                          "Others",
                                          "Mix"]
    
    var listOfSubtitle: [String] =
        ["Plastic waste with various types and shapes can be melted into plastics ore as the basics of new product.",
         "Glass waste can be melted down and destroyed as raw material for new product.",
         "Waste paper can be crushed and processed into pulp as raw material for new product.",
         "Metal waste is classified as B3. Metal waste can be melted into new products if treated properly.",
         "Types of waste that is not included in the category. Can be processed more specifically according to the type and characteristics of each.",
         "The types of waste that are not separated specifically but are still in one category"
    ]
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    
    var nextTitleLabel:String = ""
    var nextSubtitleLable:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9875925183, green: 0.770531714, blue: 0.1475356817, alpha: 1)
        
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9986478686, green: 0.7574946284, blue: 0.16169855, alpha: 1)
//    }

    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height:166)
    }
    
 
    
//   called when clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nextTitleLabel = listOfTrashCategory[indexPath.item]
        let detailTrashVC = UIStoryboard.init(name: "Education", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailTrashIdentifier") as? DetailWasteViewController
        
        let title = listOfTrashCategory[indexPath.item]
        nextSubtitleLable = listOfSubtitle[indexPath.item]
        
        detailTrashVC?.titleLabelText = title
        detailTrashVC?.subtitleLabelText = nextSubtitleLable
        detailTrashVC?.imageName = title
        
        self.navigationController?.pushViewController(detailTrashVC!, animated: true)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCollectionViewCell
        cell.imageView.image = UIImage(named: listOfTrashCategory[indexPath.item])
        cell.labelTrash.text = listOfTrashCategory[indexPath.item]
        
        return cell
    }
    

}
