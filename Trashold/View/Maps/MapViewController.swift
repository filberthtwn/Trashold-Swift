//
//  ViewController.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 19/07/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import UIKit
import MapKit
import Firebase

extension UIViewController: MKMapViewDelegate {
    // Disable keyboard when click anywhere
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

protocol InformationViewDelegate {
    func setTouch(touch:Bool)
    func bookingProcess(scheduleId:String, wasteBankId:String,namaBankUnit:String, address:String, openDate:String, openTime:String, status:Int)
    func setMapsCurrentLocation()
    func setLocation(placemark:MKPlacemark)
    func moveInformationViewDown()
}


class MapViewController: UIViewController, InformationViewDelegate, CLLocationManagerDelegate {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.view.translatesAutoresizingMaskIntoConstraints = false;
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "identifier"){
            let embedVC = segue.destination as! SearchLocationViewController
            embedVC.mapView = self.mapView
            embedVC.delegate = self
        }else if(segue.identifier == "confirmationSegue"){
            confirmationVC = segue.destination as? ConfirmationViewController
            confirmationVC?.delegate = self
        }
    }
    
    
    // Setup location manager.
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // Set up your manager properties here
        manager.delegate = self
        return manager
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchLocationContainerView: UIView!
    @IBOutlet weak var confirmationContainerView: UIView!
    @IBOutlet weak var backButtonLeading: NSLayoutConstraint!
    
    var mapViewBackendDelegate = MapViewBackend()
    let scheduleBackendDelegate = ScheduleViewBackend()
    
    let confirmationContainerViewHeight:CGFloat = 267 + 16
    let searchLocationContainerViewHeight:CGFloat = 127.5 + 24
    
    @IBOutlet weak var toggleView: UIView!
    
    var confirmationVC:ConfirmationViewController?
    
    var wasteBankList:[WasteBank] = []
    var wasteBankScheduleList:[Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        setupView()
        setupMap()
        locationManager.startUpdatingHeading()
        
        let penGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction))
        informationView.addGestureRecognizer(penGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        NotificationCenter.default.addObserver(self, selector: #selector(loadList),name:NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
        viewDidLoad()
    }
    
    func setupView(){
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.isHidden = false
        
        informationView.clipsToBounds = true
        informationView.layer.cornerRadius = 20
        informationView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        informationViewHeight.constant = 151
        
        backButtonLeading.constant = -48
        
        let tabs: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectAnnotation))
        tabs.cancelsTouchesInView = false
        mapView.addGestureRecognizer(tabs)
        
        showSearchLocationContainerView()
        
        mapViewBackendDelegate.delegate = self
        
        
        
        
    }
    
    @objc func didSelectAnnotation(){
        view.endEditing(true)
        backButtonAction(self)
    }
    
    func setupMap(){
        mapView.delegate = self
        mapView.removeAnnotations(mapView.annotations)
        setMapsCurrentLocation()
        fetchAllScheduleForAnnotation()
    }
    
    func fetchAllScheduleForAnnotation(){
        scheduleBackendDelegate.fetchAllSchedule(completion: { (scheduleList, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            self.addAnnotation(scheduleList: scheduleList)
        })
    }
    
    func addAnnotation(scheduleList:[Schedule]){
        for schedule in scheduleList{
            let wasteBankID = schedule.wasteBankId
            mapViewBackendDelegate.fetchWasteBankById(wasteBankID: wasteBankID) { (snapshotWasteBank, error) in

                guard let wasteBankId = snapshotWasteBank.wasteBankId else{
                    return
                }
                guard let wasteBankName = snapshotWasteBank.name else{
                    return
                }
                guard let wasteBankAddress = snapshotWasteBank.address else{
                    return
                }
                guard let wasteBanklatitude = snapshotWasteBank.latitude else{
                    return
                }
                guard let wasteBanklongitude = snapshotWasteBank.longitude else{
                    return
                }
                
                let wasteBankAnnotation = BankUnitAnnotation(
                    scheduleId: schedule.scheduleId,
                    wasteBankId: wasteBankId,
                    title: wasteBankName,
                    address: wasteBankAddress,
                    openDate: schedule.openDate,
                    openTime: schedule.openTime,
                    type: "bankUnit",
                    coordinate: CLLocationCoordinate2D(latitude: wasteBanklatitude, longitude:wasteBanklongitude)
                )
                self.mapView.addAnnotation(wasteBankAnnotation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        setMapsCurrentLocation()
    }
    
    func setMapsCurrentLocation(){
        // Check the autorization status.
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            guard let currentLocation = locationManager.location else {return}
            let regionRadius: CLLocationDistance = 200
            let coordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }else{
            // Request Authorization
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) || annotation.isKind(of: MKPointAnnotation.self){
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
            }
            
            let annotationImage = UIImage(named: "bankUnit-icon")
            annotationView?.image = annotationImage
            
            annotationView?.canShowCallout = true
            
        }
        annotationView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        annotationView?.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return annotationView
    }
    
    func showConfirmationContainerView(){
        confirmationContainerView.isHidden = false
        searchLocationContainerView.isHidden = true
        toggleView.isHidden = true
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.view.layoutIfNeeded()
        
        if (view.annotation?.isKind(of: BankUnitAnnotation.self))! {
            UIView.animate(withDuration: 0.1) {
                view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }
            
            guard let clickedAnnotation = view.annotation as? BankUnitAnnotation else{return}
            confirmationVC?.scheduleId = clickedAnnotation.scheduleId
            confirmationVC?.wasteBankId = clickedAnnotation.wasteBankId
            confirmationVC?.titleLabel.text = clickedAnnotation.title
            confirmationVC?.addressLabel.text = clickedAnnotation.address
            confirmationVC?.dateLabel.text = clickedAnnotation.openDate
            confirmationVC?.timeLabel.text = clickedAnnotation.openTime
            
            showConfirmationContainerView()
            
            UIView.animate(withDuration: 0.5) {
                self.backButtonLeading.constant = 8
                self.informationViewHeight.constant = self.confirmationContainerViewHeight
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if (view.annotation?.isKind(of: BankUnitAnnotation.self))! {
            UIView.animate(withDuration: 0.1) {
                view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
        }
    }
    
    @objc func panGestureAction(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            return
        case .ended:
            if confirmationContainerView.isHidden == true{
                // Automatic set informationViewHeight into 75% of backgroundView height
                if self.informationViewHeight.constant > backgroundView.frame.height * 0.45{
                    UIView.animate(withDuration: 0.5) {
                        self.informationViewHeight.constant = self.backgroundView.frame.height * 0.75
                        self.view.layoutIfNeeded()
                    }
                    // Automatic set informationViewHeight into (127,5 + 24)
                }else{
                    UIView.animate(withDuration: 0.5) {
                        self.informationViewHeight.constant = self.searchLocationContainerViewHeight
                        self.view.layoutIfNeeded()
                    }
                }
                view.endEditing(true)
            }else{
                UIView.animate(withDuration: 0.5) {
                    self.informationViewHeight.constant = self.confirmationContainerViewHeight
                    self.view.layoutIfNeeded()
                }
            }
            
        default:
            let translation = sender.translation(in: view)
            
            if confirmationContainerView.isHidden == true{
                // Stop PanGesture if informationViewHeight more than 75% of backgroundView height
                if informationViewHeight.constant >= backgroundView.frame.height * 0.75{
                    if translation.y > 0{
                        informationViewHeight.constant -= translation.y
                        sender.setTranslation(CGPoint.zero, in: view)
                    }
                }
                    // Start PanGesture if informationViewHeight more than 20% of backgroundView height
                else if informationViewHeight.constant >= searchLocationContainerViewHeight
                {
                    informationViewHeight.constant -= translation.y
                    sender.setTranslation(CGPoint.zero, in: view)
                    
                    // Handle panGesture based on swipe power
                    if  translation.y < (-35){
                        UIView.animate(withDuration: 0.5) {
                            self.informationViewHeight.constant = self.backgroundView.frame.height * 0.75
                            self.view.layoutIfNeeded()
                        }
                    }else if translation.y > (35){
                        UIView.animate(withDuration: 0.5) {
                            self.informationViewHeight.constant = self.searchLocationContainerViewHeight
                            self.view.layoutIfNeeded()
                        }
                    }
                }
            }else{
                // Translation based on swipe power, so this function make the translation flat into 4
                var tempTranslation = translation.y
                if translation.y < 0{
                    tempTranslation = -4
                }else{
                    tempTranslation = 4
                }
                
                if informationViewHeight.constant <= 270 && informationViewHeight.constant >= 264{
                    
                    informationViewHeight.constant -= tempTranslation
                    sender.setTranslation(CGPoint.zero, in: view)
                }
            }
        }
    }
    
    func setTouch(touch: Bool) {
        if touch == true {
            UIView.animate(withDuration: 0.5) {
                self.informationViewHeight.constant = (self.backgroundView?.frame.height)! * 0.75
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func moveInformationViewDown(){
        UIView.animate(withDuration: 0.5) {
            self.informationViewHeight.constant = self.searchLocationContainerViewHeight
            self.backButtonLeading.constant = -48
            self.view.layoutIfNeeded()
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        for annView in views{
            
            if annView.annotation is MKUserLocation{
                mapView.tintColor = #colorLiteral(red: 0.007843137255, green: 0.7529411765, blue: 0.7960784314, alpha: 1)
            }
            
            let endFrame = annView.frame
            annView.frame = annView.frame.offsetBy(dx: 0,dy: -50)
            UIView.animate(withDuration: 0.5) {
                annView.frame = endFrame
                self.view.layoutIfNeeded()
            }
        }

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        moveInformationViewDown()
        showSearchLocationContainerView()
        mapView.deselectAnnotation(mapView.annotations as? MKAnnotation, animated: true)
    }
    
    func showSearchLocationContainerView(){
        confirmationContainerView.isHidden = true
        searchLocationContainerView.isHidden = false
        toggleView.isHidden = false
    }
    
    func bookingProcess(scheduleId:String, wasteBankId:String, namaBankUnit:String, address:String, openDate:String, openTime:String, status:Int){
        mapViewBackendDelegate.insertSchedule(
            scheduleId: scheduleId
        )
    }
    
    func showLoadingScreen(){
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        let loadingVC = storyboard.instantiateViewController(withIdentifier: "bookingScheduleLoadingVC")
        loadingVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        loadingVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        loadingVC.loadingViewBg.isHidden = change false
        self.present(loadingVC, animated: true, completion: nil)
    }
    
    func setLocation(placemark:MKPlacemark){
        for annotation in mapView.annotations{
            if annotation.isKind(of: MKPointAnnotation.self){
                mapView.removeAnnotation(annotation)
            }
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        
        let regionRadius: CLLocationDistance = 200
        let coordinateRegion = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}






