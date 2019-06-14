//
//  LabCategoryViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ProgressHUD

class LabCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var testCatCollectionVu: UICollectionView!
    @IBOutlet weak var sideVu: UIView!
    var labCatArr = [LabCategory]()
    var isSideViewOpen:Bool = false
    var labDetailArr = [LabDetail]()
    var filtered = [LabCategory]()
    let labId = WbmDefaults.instance.getString(key: "labId")
    
    @IBOutlet weak var serchBar: UISearchBar!
    @IBOutlet weak var labCatTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        ProgressHUD.spinnerColor(#colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1))
        getLabCat()
        getLabTests()
        serchBar.isHidden = true
        sideVu.isHidden = true
        isSideViewOpen = false
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = labCatTblVu.dequeueReusableCell(withIdentifier: "labcatcell", for: indexPath) as! LabCategoryTableViewCell
        cell.nameLbl.text = filtered[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let labCatId:String = filtered[indexPath.row].id
        getTestDetail(testId: labId, testCatId: labCatId)
        isSideViewOpen = true
        sideMenu()
        self.view.endEditing(true)
        serchBar.isHidden = true
        
    }
    
    // SerchBar delegate functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            
            filtered = labCatArr
            labCatTblVu.reloadData()
            return
        }
        filtered = labCatArr.filter({ (labCategory) -> Bool in
            labCategory.name.lowercased().contains(searchText.lowercased())
        })
        labCatTblVu.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        sideMenu()
    }
    
    @IBAction func menuBtn(_ sender: Any) {
        sideMenu()
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func sideMenu(){
        
        
        sideVu.isHidden = true
        labCatTblVu.isHidden = true
        self.view.bringSubviewToFront(sideVu)
        
        if !isSideViewOpen{
            serchBar.isHidden = false
            isSideViewOpen = true
            sideVu.isHidden = false
            labCatTblVu.isHidden = false
            sideVu.frame = CGRect(x: 0, y: 120, width: 0, height: self.testCatCollectionVu.bounds.height)
            labCatTblVu.frame = CGRect(x: 0, y: 0, width: 0, height: self.testCatCollectionVu.bounds.height)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideVu.frame = CGRect(x: 0, y: 120, width: 240, height: self.testCatCollectionVu.bounds.height)
            labCatTblVu.frame = CGRect(x: 0, y: 0, width: 240, height: self.testCatCollectionVu.bounds.height)
            UIView.commitAnimations()
        }else{
            
            serchBar.isHidden = true
            sideVu.isHidden = true
            labCatTblVu.isHidden = true
            isSideViewOpen = false
            
            sideVu.frame = CGRect(x: 0, y: 120, width: 240, height: self.testCatCollectionVu.bounds.height)
            labCatTblVu.frame = CGRect(x: 0, y: 0, width: 240, height: self.testCatCollectionVu.bounds.height)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            sideVu.frame = CGRect(x: 0, y: 120, width: 0, height: self.testCatCollectionVu.bounds.height)
            labCatTblVu.frame = CGRect(x: 0, y: 0, width: 0, height: self.testCatCollectionVu.bounds.height)
            UIView.commitAnimations()
            
        }
    }
    
    // lab categories viewed on the side menu.
    func getLabCat(){
        
        labCatArr = [LabCategory]()
        let url = "\(AppUtils.returnBaseUrl())/patient/init/labtestscat"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            ProgressHUD.dismiss()
            if response.result.isSuccess{
                let json = JSON(response.result.value!)
                let valueJson = json["result"]
                print(valueJson)
                
                for (_,j) in valueJson{
                    do {
                        let labJson = LabCategory.init(fromJson: j)
                        self.labCatArr.append(labJson)
                    }
                }
                
                DispatchQueue.main.async {
                    self.filtered = self.labCatArr
                    self.labCatTblVu.reloadData()
                }
            }
            else{
                Utils.showAlert(view: self, message: (response.error?.localizedDescription)!, title: "Error")
            }
        }
        
        
    }
    
}


extension LabCategoryViewController:
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if labDetailArr.count == 0{
            self.testCatCollectionVu.setEmptyMessage("Sorry!! No Test Available according to your selected category")
            return labDetailArr.count
        }else{
            self.testCatCollectionVu.restore()
            return labDetailArr.count
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = testCatCollectionVu.dequeueReusableCell(withReuseIdentifier: "labtestcatcell", for: indexPath) as! LabTestCategoryCollectionViewCell
        cell.rateLbl.text = "Rate: " + String(labDetailArr[indexPath.row].rate)
        cell.dRateLbl.text = "Discount Rate: " + String(labDetailArr[indexPath.row].discount)
        let test = labDetailArr[indexPath.row].tests
        let imgUrl = "\(AppUtils.returnBaseUrl())\(test?.image ?? "v")".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        cell.testImgVu.downloaded(from: imgUrl!)
        cell.addTestBtn.tag = indexPath.row
        cell.addTestBtn.addTarget(self, action: #selector(testBtnPressed(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func testBtnPressed(sender:UIButton){
        let clickedBtnIndex: Int = sender.tag
        print(clickedBtnIndex)
        WbmDefaults.instance.setInt(key: "index", value: clickedBtnIndex)
        performSegue(withIdentifier: "testdetail", sender: self)
    }
    
    // filter the labtests according to the category.
    func getTestDetail(testId:String,testCatId:String){
        
        labDetailArr = [LabDetail]()
        let url = "\(AppUtils.returnBaseUrl())/patient/lab/labtests/all/\(testId)/\(testCatId)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            ProgressHUD.dismiss()
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                print(json)
                
                for (_,j) in json{
                    do{
                        let td = LabDetail(fromJson: j)
                        self.labDetailArr.append(td)
                    }
                }
                
                DispatchQueue.main.async {
                    self.testCatCollectionVu.reloadData()
                }
            }
            else
            {
                Utils.showAlert(view: self, message: (response.error?.localizedDescription)!, title: "Error")
            }
        }
    }
    
    // get all the lab tests when screen loads
    func getLabTests(){
        
        labDetailArr = [LabDetail]()
        let url = "\(AppUtils.returnBaseUrl())/patient/lab/labtests/all/\(labId)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            ProgressHUD.dismiss()
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                print(json)
                for (_,j) in json{
                    
                    do{
                        let td = LabDetail(fromJson: j)
                        self.labDetailArr.append(td)
                    }
                }
                
                
                DispatchQueue.main.async {
                    self.testCatCollectionVu.reloadData()
                }
            }else {
                Utils.showAlert(view: self, message: (response.error?.localizedDescription)!, title: "Error")
                
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        let collectioHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth/2, height: collectioHeight/2)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}


