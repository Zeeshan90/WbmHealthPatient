//
//  SpecialityViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/9/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SpecialityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {
    
    
    var specialityArr = [Speciality]()
    var filtered = [Speciality]()
    @IBOutlet weak var specialityTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        specialityTblVu.tableFooterView = UIView()
        Utils.setSearchBar(controller: self, updater: self)
        getSpeciality()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = specialityTblVu.dequeueReusableCell(withIdentifier: "specialitycell", for: indexPath) as! SpecialityTableViewCell
        cell.titleLbl.text = filtered[indexPath.row].specialityDesc
        cell.img.downloaded(from: "\(AppUtils.returnBaseUrl())\(specialityArr[indexPath.row].image!)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.isNavigationBarHidden = false
            
            let selectedCellId = self.filtered[indexPath.row].id
            print(selectedCellId)
            print(self.specialityArr[indexPath.row].specialityDesc)
            WbmDefaults.instance.setString(key: "specialityId", value: selectedCellId!)
            self.performSegue(withIdentifier: "todoctors", sender: self)
            self.specialityTblVu.deselectRow(at: indexPath, animated: true)
        }
    
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        guard !searchText.isEmpty else {
            
            filtered = specialityArr
            specialityTblVu.reloadData()
            return
        }
        filtered = specialityArr.filter({ (speciality) -> Bool in
            return speciality.specialityDesc.lowercased().contains(searchText.lowercased())
        })
        specialityTblVu.reloadData()
    }
    
    func getSpeciality(){
        specialityArr = [Speciality]()
        let url = "\(AppUtils.returnBaseUrl())/patient/init/specialities"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
               
                let json = JSON(response.result.value!)
                let dataJson = json["data"]
                print(dataJson)
                
                for (_,j) in dataJson{
                    do {
                        let special = Speciality(fromJson: j)
                        self.specialityArr.append(special)
                    }
                }
               
                DispatchQueue.main.async {
                    self.filtered = self.specialityArr
                    self.specialityTblVu.reloadData()
                }
            }else
            {
                print(response.error as Any)
            }
        }
    }
}
