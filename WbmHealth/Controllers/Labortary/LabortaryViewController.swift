//
//  LabortaryViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD
import CoreLocation

class LabortaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var labTblVu: UITableView!
    @IBOutlet weak var srchBar: UISearchBar!
    var labArr = [Labortaries]()
    var filteredArr = [Labortaries]()
    var refreshController = UIRefreshControl()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var lat: String = ""
    var lon: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        labTblVu.tableFooterView = UIView()
        navigationController!.view.backgroundColor = UIColor.white
        
        ProgressHUD.show()
        ProgressHUD.spinnerColor(#colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1))
        
        labTblVu.refreshControl = self.refreshController
        refreshController.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        refreshController.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        srchBar.showsCancelButton = true
        
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
           
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
      
    }
    
    @objc func refresh(){
        //labArr = [Labortaries]()
        //getAllLabs()
        //self.refreshController.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locationManager.location
            print("Latitude",currentLocation.coordinate.latitude)
            print("Longitude",currentLocation.coordinate.longitude)
            lat = "\(currentLocation.coordinate.latitude)"
            lon = "\(currentLocation.coordinate.longitude)"
            
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        getAllLabs()

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            
            filteredArr = labArr
            //view.endEditing(true)
            labTblVu.reloadData()
            return
        }
        filteredArr = labArr.filter({lab -> Bool in
            
            lab.laboratoryName.lowercased().contains(searchText.lowercased())
           // guard let text = searchBar.text else { return false }
            //return ((lab.laboratoryName.lowercased().contains(text.lowercased())))
        })
        
        labTblVu.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if labArr.count == 0{
            self.labTblVu.setEmptyMessage("No labortary Available")
        }else{
            self.labTblVu.restore()
            
        }
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = labTblVu.dequeueReusableCell(withIdentifier: "labcell", for: indexPath) as! LabortaryTableViewCell
        cell.labortaryName.text = filteredArr[indexPath.row].laboratoryName
        let imgUrl = "\(AppUtils.returnBaseUrl())/\(filteredArr[indexPath.row].image ?? "hg")".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        cell.img.downloaded(from: imgUrl!)
       return cell
    }

   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let labId:String = labArr[indexPath.row].id
        WbmDefaults.instance.setString(key: "labId", value: labId)
        WbmDefaults.instance.setString(key: "id", value: labId)
        WbmDefaults.instance.setString(key: "controller", value: "laboratory")
        performSegue(withIdentifier: "tomap", sender: self)
        //performSegue(withIdentifier: "tolabdetail", sender: self)
    }
    
   
    @IBAction func crossBtn(_ sender: Any) {
        ProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func getAllLabs(){
        
        labArr = [Labortaries]()
        let url = "\(AppUtils.returnBaseUrl())/patient/nearbylaboratories"
        Alamofire.request(url, method: .post, parameters: [
            "lon":lon,
            "lat":lat
            ]).responseJSON{
            response in
            self.refreshController.endRefreshing()
             ProgressHUD.dismiss()
            if response.result.isSuccess{
                
               
                let json = JSON(response.result.value!)
                print(json)
                
                for (_,j) in json{
                    do {
                        let labjson = Labortaries(fromJson: j)
                        print(labjson)
                        self.labArr.append(labjson)
                    }
                }
                
                DispatchQueue.main.async {
                    self.filteredArr = self.labArr
                     self.labTblVu.reloadData()
                }
               
            }else{
                Utils.showAlert(view: self, message: (response.error?.localizedDescription)!, title: "Error")
                
            }
            
        }
    }
}
