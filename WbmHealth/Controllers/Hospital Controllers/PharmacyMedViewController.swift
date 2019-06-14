//
//  PharmacyMedViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 14/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class PharmacyMedViewController: UIViewController,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate {
    
    var medArr = [Medicine]()
    var filtered = [Medicine]()
    var pharId: String = WbmDefaults.instance.getString(key: "pharId")
    @IBOutlet weak var medTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ProgressHUD.show()
        //setSearchBar()
        Utils.setSearchBar(controller: self)
        getMedicine()
        
    }
    
    
    // Custom Search in the navigation bar
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
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        guard !searchText.isEmpty else {

            filtered = medArr
            medTblVu.reloadData()
            return
        }
        filtered = medArr.filter({ (med) -> Bool in
            return med.id.lowercased().contains(searchText.lowercased())
        })
        medTblVu.reloadData()
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medTblVu.dequeueReusableCell(withIdentifier: "medcell", for: indexPath) as! PharMedicineTableViewCell
        cell.setData(medName: filtered[indexPath.row].type)
        return cell
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.medTblVu.deselectRow(at: indexPath, animated: true)
    }
    func getMedicine(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/pharmacy/medicines/all/" + pharId
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            
            response in
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                print(json)
                for (_,j) in json{
                    do{
                        self.medArr.append(Medicine(fromJson: j))
                    }
                }
                
                DispatchQueue.main.async {
                    self.filtered = self.medArr
                    self.medTblVu.reloadData()
                }
                
            }else{
                
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }
    
    
}
