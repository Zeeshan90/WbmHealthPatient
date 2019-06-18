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
        Utils.setSearchBar(controller: self, updater: self)
        getMedicine()
        
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
            return med.medicineName.lowercased().contains(searchText.lowercased())
        })
        medTblVu.reloadData()
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medTblVu.dequeueReusableCell(withIdentifier: "medcell", for: indexPath) as! PharMedicineTableViewCell
        
        
        let imgUrl: String = "\(AppUtils.returnBaseUrl())\(filtered[indexPath.row].photo ?? "gh")"
        cell.setData(medName: filtered[indexPath.row].medicineName, description: filtered[indexPath.row].medsDescriptionField, price: String(filtered[indexPath.row].price), photo: imgUrl)
        
        cell.addBtn.tag = indexPath.row
        cell.addBtn.addTarget(self, action: #selector(addBtnPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func addBtnPressed(_ sender: UIButton){
        
        let medId: String = filtered[sender.tag].id
        WbmDefaults.instance.setString(key: "medId", value: medId)
        performSegue(withIdentifier: "tomeddetail", sender: self)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.medTblVu.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
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
