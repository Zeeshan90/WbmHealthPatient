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
class LabortaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var labTblVu: UITableView!
    
    var labArr = [Labortaries]()
    
    var refreshController = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        ProgressHUD.spinnerColor(#colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1))
        labTblVu.refreshControl = self.refreshController
        refreshController.addTarget(self, action:  #selector(refresh), for: .valueChanged)
        refreshController.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(){
        getAllLabs()
        self.refreshController.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        getAllLabs()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = labTblVu.dequeueReusableCell(withIdentifier: "labcell", for: indexPath) as! LabortaryTableViewCell
        cell.labortaryName.text = labArr[indexPath.row].laboratoryName
        let imgUrl = "\(AppUtils.returnBaseUrl())\(labArr[indexPath.row].image ?? "hg")".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        cell.img.downloaded(from: imgUrl!)
       return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return labArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tolabcat", sender: self)
    }
    
   
    @IBAction func crossBtn(_ sender: Any) {
        ProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func getAllLabs(){
        
        labArr = [Labortaries]()
        let url = "\(AppUtils.returnBaseUrl())/patient/laboratory/all"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                ProgressHUD.dismiss()
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
                    self.labTblVu.reloadData()
                }
               
            }else{
                print(response.error as Any)
            }
            
        }
    }
}
