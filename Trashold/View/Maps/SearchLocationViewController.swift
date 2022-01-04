//
//  FirstViewController.swift
//  TrasholdTutorial
//
//  Created by Filbert Hartawan on 06/08/19.
//  Copyright © 2019 trashold. All rights reserved.
//

import UIKit
import MapKit

class SearchLocationViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var delegate:InformationViewDelegate?
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationTableView: UITableView!
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?
//    trailing
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        locationTextField.delegate = self
        locationTextField.addTarget(self, action: #selector(locationTextFieldAction), for: .touchDown)
        locationTextField.addTarget(self, action: #selector(locationTextFieldTextUpdate), for: .editingChanged)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        matchingItems.removeAll()
        locationTableView.reloadData()
        locationTextField.text = ""
    }
    
    func setupViews(){
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.isHidden = true
        locationTableView.register(UINib(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @objc func locationTextFieldTextUpdate(){
        updateLocationTableView()
    }
    
    @objc func locationTextFieldAction(textField: UITextField, topContraint: NSLayoutConstraint ) {
        locationTableView.isHidden = false
        delegate?.setTouch(touch: true)
    }
    
    @IBAction func reLocationAction(_ sender: Any) {
        delegate?.moveInformationViewDown()
//        delegate?.setMapsCurrentLocation()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
        let selectedItem = matchingItems[indexPath.item].placemark
        cell.titleLabel.text = selectedItem.name
        cell.subtitleLabel.text = selectedItem.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.item].placemark
        delegate?.setLocation(placemark: selectedItem)
        delegate?.moveInformationViewDown()
        tableView.reloadData()
        
    }
    
    func updateLocationTableView(){
        guard let mapView = self.mapView, let locationTextFieldText = locationTextField.text else {
            return
        }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationTextFieldText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start{ response,_ in
            guard let response = response else{
                return
            }
            self.matchingItems = response.mapItems
            self.locationTableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateLocationTableView()
        
        return true
    }
}
