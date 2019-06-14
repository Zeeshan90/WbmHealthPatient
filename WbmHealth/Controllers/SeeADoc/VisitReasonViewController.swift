//
//  VisitReasonViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ProgressHUD

class VisitReasonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var reasonTblVu: UITableView!
    @IBOutlet weak var searchVu: UISearchBar!
    var reasonArr = [Reason]()
    var filtered = [Reason]()
    let util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgressHUD.show("Please wait")
        searchVu.showsCancelButton = true
        getReasons()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reasonTblVu.dequeueReusableCell(withIdentifier: "visitreasoncell", for: indexPath) as! VisitReasonTableViewCell
        cell.nameLbl.text = filtered[indexPath.row].text
        cell.vu.layer.borderWidth = 1
        cell.vu.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cell.vu.layer.cornerRadius = cell.vu.frame.height/2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tosymptoms", sender: self)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchVu.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filtered = reasonArr
            reasonTblVu.reloadData()
            return
        }
        
        filtered = reasonArr.filter({ (reason) -> Bool in
            reason.text.lowercased().contains(searchText.lowercased())
        })
        reasonTblVu.reloadData()
    }
    
    func getReasons(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/init/dodreasons"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                
                let json: JSON = JSON(response.result.value!)
                let resultJson = json["result"]
                print(resultJson)
                
                for (_,j) in resultJson{
                    
                    let reasonJson = Reason(fromJson: j)
                    self.reasonArr.append(reasonJson)
                }
                
                DispatchQueue.main.async {
                    self.filtered = self.reasonArr
                    self.reasonTblVu.reloadData()
                }
                
            }else{
                print(response.error?.localizedDescription as Any)
            }
        }
    }
}
