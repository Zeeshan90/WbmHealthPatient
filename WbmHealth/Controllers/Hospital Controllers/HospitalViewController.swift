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
class HospitalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{
    
    
    
    
    @IBOutlet weak var hospTblVu: UITableView!
    var filter = [Hospital]()
    var hospitalArr = [Hospital]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.setSearchBar(controller: self)
        // Do any additional setup after loading the view.
    }
    
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
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = hospTblVu.dequeueReusableCell(withIdentifier: "hospitalcell", for: indexPath) as! HospitalTableViewCell
        
        return cell
    }
    
    func getAllHospitals(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                for (_,j) in json{
                    do{
                        //self.hospitalArr.append(Hospital())
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
