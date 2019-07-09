//
//  HospitalViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation

class HospitalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,CLLocationManagerDelegate{
    
    
    @IBOutlet weak var hospTblVu: UITableView!
    var filter = [Hospital]()
    var hospitalArr = [Hospital]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var lat: String = ""
    var lon: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //Utils.setSearchBar(controller: self)
        
        locationManager.delegate =  self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locationManager.location
            print("Latitude",currentLocation.coordinate.latitude)
            print("Longitude",currentLocation.coordinate.longitude)
            lat = "\(currentLocation.coordinate.latitude)"
            lon = "\(currentLocation.coordinate.longitude)"
            getAllHospitals()
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        print(location.coordinate.latitude)
//    }
    @IBAction func crossBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
//        guard !searchText.isEmpty else {
//            
//            filtered = medArr
//            medTblVu.reloadData()
//            return
//        }
//        filtered = medArr.filter({ (med) -> Bool in
//            return med.id.lowercased().contains(searchText.lowercased())
//        })
//        medTblVu.reloadData()
    }
    
    func setSearchBar(){
        
        var searchController = UISearchController()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hospTblVu.dequeueReusableCell(withIdentifier: "hospitalcell", for: indexPath) as! HospitalTableViewCell
        cell.hospName.text = hospitalArr[indexPath.row].hospitalId.hospitalName
        return cell
    }
    
    func getAllHospitals(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/nearbyhospitals"
        Alamofire.request(url, method: .post, parameters: [
            "lon":lon,
            "lat":lat
        ]).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                let dataJson = json["data"]
                print(dataJson)
                for (_,j) in dataJson{
                    do{
                        
                        self.hospitalArr.append(Hospital(fromJson: j))
                    }
                }
                
                DispatchQueue.main.async {
                    self.filter = self.hospitalArr
                    self.hospTblVu.reloadData()
                }
            }else{
                
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }

}
