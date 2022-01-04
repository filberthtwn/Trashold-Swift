//
//  DetailWasteViewController.swift
//  HomeButton
//
//  Created by Olivia Kwandy on 13/08/19.
//  Copyright © 2019 Olivia Kwandy. All rights reserved.
//

import UIKit

class DetailWasteViewController:UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var detailTrashHeightVIew: NSLayoutConstraint!
    @IBOutlet weak var viewLuarBottomView: UIView!
    @IBOutlet weak var sliderUpDown: UIView!
    
    
    @IBOutlet weak var detailTrashImageView: UIImageView!
    @IBOutlet weak var detailTrashTitleLabel: UILabel!
    @IBOutlet weak var detailTrashSubtitleLabel: UILabel!
    @IBOutlet weak var detailTrashPriceLabel: UILabel!
    
    @IBOutlet weak var viewPanGesture: UIView!
    var titleLabelText:String?
    var subtitleLabelText:String?
    var imageName:String?
    var kodeSampah:Int?
    
    
    var delegate:DetailWasteViewController?
    
    let detailTrashList:[[TrashInfo]] = [
        [TrashInfo(trashTitle: "Colored Plastic Bottle", trashPrice: "IDR 1.000/kg", trashImageName: "coloredPlasticBottle"),
         TrashInfo(trashTitle: "Solid Plastic", trashPrice: "IDR 200/kg", trashImageName: "solidPlastic"),
         TrashInfo(trashTitle: "White Plastic Bottle", trashPrice: "IDR 50/kg", trashImageName: "whitePlasticBottle"),
         TrashInfo(trashTitle: "Bottle or Gallon Cap", trashPrice: "IDR 3.300/kg", trashImageName: "bottleOrGallonCap")
        ],
        [TrashInfo(trashTitle: "Colored Bottle", trashPrice: "IDR 600/kg", trashImageName: "coloredBottle"),
         TrashInfo(trashTitle: "Glass", trashPrice: "IDR 50/kg", trashImageName: "gelas"),
         TrashInfo(trashTitle: "Bowl", trashPrice: "IDR  50/kg", trashImageName: "bowl"),
         TrashInfo(trashTitle: "Clear Bottle", trashPrice: "IDR 400/kg", trashImageName: "clearBottle"),
        ],
        [TrashInfo(trashTitle: "Cardboard", trashPrice: "IDR 1.000/kg", trashImageName: "cardboard"),
         TrashInfo(trashTitle: "HVS", trashPrice: "IDR 2.200/kg", trashImageName: "hvs"),
         TrashInfo(trashTitle: "Food Packaging", trashPrice: "IDR 400/kg", trashImageName: "foodPackaging"),
         TrashInfo(trashTitle: "Newspaper", trashPrice: "IDR 2.500/kg", trashImageName: "newspaper")
        ],
        [TrashInfo(trashTitle: "Cans", trashPrice: "IDR 2.500/kg", trashImageName: "cans"),
         TrashInfo(trashTitle: "Spikes", trashPrice: "IDR 1.000/kg", trashImageName: "spikes"),
         TrashInfo(trashTitle: "Iron", trashPrice: "IDR 2.200/kg", trashImageName: "iron"),
         TrashInfo(trashTitle: "Pan", trashPrice: "IDR 9.500/kg", trashImageName: "pan")
        ],
        [TrashInfo(trashTitle: "Used Cooking Oil", trashPrice: "IDR 4.300/kg", trashImageName: "usedCookingOil"),
         TrashInfo(trashTitle: "VCD", trashPrice: "IDR 3.300/kg", trashImageName: "vcd"),
         TrashInfo(trashTitle: "Rubber", trashPrice: "IDR 500/kg", trashImageName: "rubber"),
         TrashInfo(trashTitle: "Pipe", trashPrice: "IDR 400/kg", trashImageName: "pipe")
        ],
        [TrashInfo(trashTitle: "Mixed Plastic", trashPrice: "IDR 250/kg", trashImageName: "mixedPlastic"),
         TrashInfo(trashTitle: "Mixed Glass", trashPrice: "IDR 50/kg", trashImageName: "mixedGlass"),
         TrashInfo(trashTitle: "Mixed Paper", trashPrice: "IDR 400/kg", trashImageName: "mixedPaper"),
         TrashInfo(trashTitle: "Mixed Metal", trashPrice: "IDR 500/kg", trashImageName: "mixedMetal")
        ]
        
    ]
    
    let detailTrashInfoList:[[TrashDetailInfo]] = [
        [TrashDetailInfo(trashDetailTitle: "Colored Plastic Bottle", trashDetailSubtitle: "All types of cans attached to magnets. ", trashDetailPrice: "IDR 1.000/kg", trashDetailImageName: "plastic1"),
         TrashDetailInfo(trashDetailTitle: "Solid Plastic", trashDetailSubtitle: "Waste from empty colored plastic bottles such  as green, dark blue and other  colors. It's important to squeeze the plastic Bottles to maximize the delivery space.", trashDetailPrice: "IDR 200/kg", trashDetailImageName: "plastic2"),
         TrashDetailInfo(trashDetailTitle: "White Plastic Bottle", trashDetailSubtitle: "Waste from plastic bottles that are colorless or clear and clean. It's important to squeeze the plastic bottles to maximize delivery space.", trashDetailPrice: "IDR 2.300/kg", trashDetailImageName: "plastic3"),
         TrashDetailInfo(trashDetailTitle: "Bottle or Gallon Cap", trashDetailSubtitle: "All types of gallon and bottle caps which made of plastic.", trashDetailPrice: "IDR 3.300/kg", trashDetailImageName: "plastic4")],
        
        [TrashDetailInfo(trashDetailTitle: "Colored Bottle", trashDetailSubtitle: "Types of transparent bottles such as syrup bottles, soy sauce bottles or sauces and gasoline bottles", trashDetailPrice: "IDR 600/pcs", trashDetailImageName: "glass1"),
         TrashDetailInfo(trashDetailTitle: "Glass", trashDetailSubtitle: "Types of glass that is still in good condition or already in the form of fraction", trashDetailPrice: "IDR 50/kg", trashDetailImageName: "glass2"),
         TrashDetailInfo(trashDetailTitle: "Bowl", trashDetailSubtitle: "Type of bowl that  is  still in good condition or  already in the form of fractions.", trashDetailPrice: "IDR 50/kg", trashDetailImageName: "glass3"),
         TrashDetailInfo(trashDetailTitle: "Clear BOttle", trashDetailSubtitle: "Types of transparent bottle such as syrup bottles, soy sauce bottles or sauces and gasoline bottles", trashDetailPrice: "IDR 400/kg", trashDetailImageName: "glass4")],
        
        [TrashDetailInfo(trashDetailTitle: "Cardboard", trashDetailSubtitle: "Packaging boxes which are usually box-shaped and made from white or brown carton. It's important to fold the paper to maximize delivery space.", trashDetailPrice: "IDR 1.000/kg", trashDetailImageName: "paper1"),
         TrashDetailInfo(trashDetailTitle: "HVS", trashDetailSubtitle: "Thin white paper, whether it is clean or has streaks. Like notebooks and print books", trashDetailPrice: "IDR 2.200/kg", trashDetailImageName: "paper2"),
         TrashDetailInfo(trashDetailTitle: "Food Packaging", trashDetailSubtitle: "Types of paper that are rather thick and colored such as box of snakcs, milk, etc. It's important to fold the paper to  maximize delivery space.", trashDetailPrice: "IDR 2.500/kg", trashDetailImageName: "paper3"),
         TrashDetailInfo(trashDetailTitle: "Newspaper", trashDetailSubtitle: "Newspapers that use opaque paper, not grease or wet.", trashDetailPrice: "IDR 2.500/kg", trashDetailImageName: "paper4")
        ],
        
        [TrashDetailInfo(trashDetailTitle: "Cans", trashDetailSubtitle: "All types of cans attached to magnets. For example beverages, food cans, pylox spray, insect spray,etc.", trashDetailPrice: "IDR 2.500/kg", trashDetailImageName: "can1"),
         TrashDetailInfo(trashDetailTitle: "Spikes", trashDetailSubtitle: "Various types of spikes that are not used", trashDetailPrice: "IDR 1.000/kg", trashDetailImageName: "can2"),
         TrashDetailInfo(trashDetailTitle: "Iron", trashDetailSubtitle: "All types of iron include chains, thick piper irons, motorcycle wheels, etc.", trashDetailPrice: "IDR 2.200/kg", trashDetailImageName: "can3"),
         TrashDetailInfo(trashDetailTitle: "Pan", trashDetailSubtitle: "All pan which are made of aluminium and no crust left", trashDetailPrice: "IDR 9.500/kg", trashDetailImageName: "can4")],
        
        [TrashDetailInfo(trashDetailTitle: "Used Cooking Oil", trashDetailSubtitle: "Waste from used cooking oil that has used several times or is turbid and smelly", trashDetailPrice: "IDR 4.300/kg", trashDetailImageName: "others1"),
         TrashDetailInfo(trashDetailTitle: "VCD", trashDetailSubtitle: "VCD chip that are not used", trashDetailPrice: "IDR 3.300/KG", trashDetailImageName: "others2"),
         TrashDetailInfo(trashDetailTitle: "Rubber", trashDetailSubtitle: "All types of goods which are made from rubber include tires, sandals, shoes", trashDetailPrice: "IDR 500/kg", trashDetailImageName: "others3"),
         TrashDetailInfo(trashDetailTitle: "Pipe", trashDetailSubtitle: "Types of plastic waste from various  brands and colors", trashDetailPrice: "IDR 400/kg", trashDetailImageName: "others4")],
        
        [TrashDetailInfo(trashDetailTitle: "Mixed Plastic", trashDetailSubtitle: "All  types of plastic waste", trashDetailPrice: "IDR 250/kg", trashDetailImageName: "mix1"),
         TrashDetailInfo(trashDetailTitle: "Mixed Glass", trashDetailSubtitle: "All types of waste which made from  glass.", trashDetailPrice:"IDR 50/kg", trashDetailImageName: "mix2"),
         TrashDetailInfo(trashDetailTitle: "Mixed Paper", trashDetailSubtitle: "All types of paper waste. it's important to fold the paper to maximze delivery space.", trashDetailPrice: "IDR  400/kg", trashDetailImageName: "mix3"),
         TrashDetailInfo(trashDetailTitle: "Mixed Metal", trashDetailSubtitle: "All types of metal waste", trashDetailPrice: "idr 500/kg", trashDetailImageName: "mix4")]
        
    ]
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        print("ABC")
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9999848008, green: 0.8354597092, blue: 0.1511399448, alpha: 1)
//        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        self.navigationController?.navigationBar.shadowImage = nil
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        typesTableView.delegate = self
        typesTableView.dataSource = self
        typesTableView.register(UINib(nibName: "TypeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        setupViews()
        viewLuarBottomView.layer.cornerRadius = 20
        viewLuarBottomView.layer.masksToBounds = true
        viewLuarBottomView.layer.maskedCorners =  [.layerMinXMinYCorner,. layerMaxXMinYCorner]
        
        sliderUpDown.layer.cornerRadius = 2
        sliderUpDown.layer.masksToBounds = true
        
        overlayView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        overlayView.addGestureRecognizer(tapGesture)
        
       
        verifyKodeSampah()
        
        
    }
    
    @objc func tapGesture(){
        
        detailTrashHeightVIew.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.detailTrashHeightVIew.constant = 0
            self.view.layoutIfNeeded()
        }
        overlayView.isHidden = true
        UIView.animate(withDuration: 1.0) {
            self.overlayView.isHidden = true
        }
    }
    
    func setupViews(){
        self.titleLabel.text = titleLabelText
        self.trashImageView.image = UIImage(named: imageName!)
        self.subtitleLabel.text  = subtitleLabelText
        
        
        
        typesTableView.sectionHeaderHeight = CGFloat(signOf: 414, magnitudeOf: 40)
        detailTrashHeightVIew.constant = 0
        
    }
    
    func verifyKodeSampah(){
        switch titleLabelText {
        case "Plastic":
            kodeSampah = 0
        case "Glass":
            kodeSampah = 1
        case "Paper":
            kodeSampah = 2
        case "Metal":
            kodeSampah = 3
        case "Others":
            kodeSampah = 4
        default:
            kodeSampah = 5
        }
    }
    
    //    ini buat arraynya sesuai urutan  012345
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TypeTableViewCell
        
        cell.titleLabel.text = detailTrashList[kodeSampah!][indexPath.item].trashTitle
        cell.priceLabel.text = detailTrashList[kodeSampah!][indexPath.item].trashPrice
        cell.imageType.image = UIImage(named: detailTrashList[kodeSampah!][indexPath.item].trashImageName!)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailTrashTitleLabel.text = detailTrashInfoList[kodeSampah!][indexPath.item].trashDetailTitle
        detailTrashImageView.image = UIImage(named: detailTrashInfoList[kodeSampah!][indexPath.item].trashDetailImageName!)
        detailTrashPriceLabel.text =
            detailTrashInfoList[kodeSampah!][indexPath.item].trashDetailPrice
        detailTrashSubtitleLabel.text =
            detailTrashInfoList[kodeSampah!][indexPath.item].trashDetailSubtitle
        
        overlayView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.detailTrashHeightVIew.constant = 350
            self.view.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Types"
        
    }
    
    
    @IBAction func panViewLuar(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case.began:
            return
            
        case.ended:
            if detailTrashHeightVIew.constant <= 300 {
                detailTrashHeightVIew.constant = 0
                UIView.animate(withDuration: 0.5) {
                    self.detailTrashHeightVIew.constant = 0
                    self.view.layoutIfNeeded()
                }
                overlayView.isHidden = true
                
            }
            
        default:
            let translation = sender.translation(in: view)
            if detailTrashHeightVIew.constant >= 350 {
                if translation.y > 0{
                    detailTrashHeightVIew.constant -= translation.y
                    sender.setTranslation(.zero, in: view)
                }
            }else{
                detailTrashHeightVIew.constant -= translation.y
                sender.setTranslation(.zero, in: view)
            }
        }
    }
}
