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
import NVActivityIndicatorView

class HospitalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,CLLocationManagerDelegate,NVActivityIndicatorViewable{
    
    
    @IBOutlet weak var hospTblVu: UITableView!
    var filter = [Hospital]()
    var hospitalArr = [Hospital]()
    
    var sendId: String = ""
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var lat: String = ""
    var lon: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.instance.startIndicator(type: 2)
        Utils.setSearchBar(controller: self, updater: self)
        hospTblVu.tableFooterView = UIView()
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
            getAllHospitals(lon: currentLocation.coordinate.longitude, lat: currentLocation.coordinate.latitude)
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    @IBAction func crossBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {

        guard !searchText.isEmpty else {

            filter = hospitalArr
            hospTblVu.reloadData()
            return
        }
        filter = hospitalArr.filter({ (hospital) -> Bool in
            return hospital.hospitalName.lowercased().contains(searchText.lowercased())
        })
        hospTblVu.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hospTblVu.dequeueReusableCell(withIdentifier: "hospitalcell", for: indexPath) as! HospitalTableViewCell
        cell.hospName.text = filter[indexPath.row].hospitalName
        cell.addressLbl.text = filter[indexPath.row].hospitalAddress
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WbmDefaults.instance.setString(key: "id", value: filter[indexPath.row].id)
        WbmDefaults.instance.setString(key: "controller", value: "hospital")
        performSegue(withIdentifier: "tomap", sender: self)
        self.hospTblVu.deselectRow(at: indexPath, animated: true)
    }
    
    func getAllHospitals(lon:Double,lat:Double){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/nearbyhospitals"
        Alamofire.request(url, method: .post, parameters: [
            "lon":lon,
            "lat":lat
        ]).responseJSON{
            
            response in
            
            self.stopAnimating()
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                
                print(json)
                for (_,j) in json{
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
