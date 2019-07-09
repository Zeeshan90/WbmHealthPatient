//
//  ViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    
    // Options View Outlets
    @IBOutlet weak var labortaryVu: UIView!
    @IBOutlet weak var medHisVu: UIView!
    @IBOutlet weak var workOutVu: UIView!
    @IBOutlet weak var bmmiCalVu: UIView!
    @IBOutlet weak var healthTipsVu: UIView!
    @IBOutlet weak var appoinmentVu: UIView!
    @IBOutlet weak var seeADocVu: UIView!
    @IBOutlet weak var nearByPharmmancyVu: UIView!
    @IBOutlet weak var nearByHospitalVu: UIView!
    @IBOutlet weak var bottomVu: UIView!
    @IBOutlet weak var cartBtn: UIBarButtonItem!
    @IBOutlet weak var testCollectionView: UICollectionView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var fitBitVu: UIView!
    var topNameArr = ["My Accounts","Forums","Emergency","Health Blogs"]
    var topImgArr = ["1","2","3","4"]
    var testArr = [CommonLabTest]()
    let util = Utils()
    var i: Int = 0
    var btnBarBadge: MJBadgeBarButton!
    var cart = [LabTests]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCommonLabTests()
        cart = AppUtils.sharedInstance.getAllCartProducts()
        i = cart.count
        self.navigationItem.rightBarButtonItem = nil
//        self.navigationItem.rightBarButtonItem = self.cartBtn
        setupBadge()
        Utils.cardView(view: labortaryVu)
        Utils.cardView(view: labortaryVu)
        Utils.cardView(view: medHisVu)
        Utils.cardView(view: workOutVu)
        Utils.cardView(view: bmmiCalVu)
        Utils.cardView(view: healthTipsVu)
        Utils.cardView(view: appoinmentVu)
        Utils.cardView(view: seeADocVu)
        Utils.cardView(view: nearByPharmmancyVu)
        Utils.cardView(view: nearByHospitalVu)
        Utils.cardView(view: bottomVu)
        
       
        let workOutClick = UITapGestureRecognizer(target: self, action: #selector(tapOnWorkOut))
        workOutVu.addGestureRecognizer(workOutClick)
        let labClick = UITapGestureRecognizer(target: self, action: #selector(tapOnLab))
        labortaryVu.addGestureRecognizer(labClick)
        let medHis = UITapGestureRecognizer(target: self, action: #selector(tapOnMedHis))
        medHisVu.addGestureRecognizer(medHis)
        let bmiCal = UITapGestureRecognizer(target: self, action: #selector(tapOnBmiCal))
        bmmiCalVu.addGestureRecognizer(bmiCal)
        let healthTips = UITapGestureRecognizer(target: self, action: #selector(tapOnHelthTip))
        healthTipsVu.addGestureRecognizer(healthTips)
        let appoinment = UITapGestureRecognizer(target: self, action: #selector(tapOnappointment))
        appoinmentVu.addGestureRecognizer(appoinment)
        let seeDoc = UITapGestureRecognizer(target: self, action: #selector(tapOnseeDoc))
        seeADocVu.addGestureRecognizer(seeDoc)
        let nearPhar = UITapGestureRecognizer(target: self, action: #selector(tapOnNearPhar))
        nearByPharmmancyVu.addGestureRecognizer(nearPhar)
        let nearHosp = UITapGestureRecognizer(target: self, action: #selector(tapOnNearHosp))
        nearByHospitalVu.addGestureRecognizer(nearHosp)
        let fitbitVu = UITapGestureRecognizer(target: self, action: #selector(topOnFitbit))
        fitBitVu.addGestureRecognizer(fitbitVu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cart = AppUtils.sharedInstance.getAllCartProducts()
        i = cart.count
        btnBarBadge.badgeValue = "\(i)"
    }
    @objc func topOnFitbit(){
        performSegue(withIdentifier: "tofitbit", sender: self)
    }
    func setupBadge(){
        
        let customButton = UIButton(type: UIButton.ButtonType.custom)
        customButton.frame = CGRect(x: 0, y: 0, width: 35.0, height: 35.0)
        customButton.addTarget(self, action: #selector(self.chartBtn), for: .touchUpInside)
        customButton.setImage(UIImage(named: "cart"), for: .normal)
        customButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnBarBadge = MJBadgeBarButton()
        self.btnBarBadge.setup(customButton: customButton)
        self.btnBarBadge.shouldAnimateBadge = true
        self.btnBarBadge.badgeOriginX = 20.0
        self.btnBarBadge.badgeOriginY = -4
        self.btnBarBadge.shouldHideBadgeAtZero = true
        self.btnBarBadge.badgeValue = "\(cart.count)"
        self.navigationItem.rightBarButtonItem = self.btnBarBadge
    }
    
    @objc func chartBtn() {
        
        performSegue(withIdentifier: "tocart", sender: self)
        //        let rootController = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        //        self.navigationController?.pushViewController(rootController, animated: true)
    }
    
    
    @objc func tapOnMedHis(){
        performSegue(withIdentifier: "medicalhistory", sender: self)
    }
    @objc func tapOnBmiCal(){
        performSegue(withIdentifier: "tobmical", sender: self)
    }
    @objc func tapOnHelthTip(){
        performSegue(withIdentifier: "tohealthtips", sender: self)
    }
    @objc func tapOnappointment(){
        performSegue(withIdentifier: "toappoint", sender: self)
    }
    @objc func tapOnseeDoc(){
        performSegue(withIdentifier: "seeDoc", sender: self)
    }
    @objc func tapOnNearPhar(){
        performSegue(withIdentifier: "topharmacy", sender: self)
    }
    @objc func tapOnNearHosp(){
        performSegue(withIdentifier: "tohospital", sender: self)
    }
    
    @objc func tapOnWorkOut(){
        performSegue(withIdentifier: "workout", sender: self)
    }
    
    @objc func tapOnLab(){
        performSegue(withIdentifier: "labortaries", sender: self)
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == topCollectionView{
            return topNameArr.count
        }else{
            return testArr.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topCollectionView{
            let cell = topCollectionView.dequeueReusableCell(withReuseIdentifier: "topcell", for: indexPath) as! TopCollectionViewCell
            cell.name.text = topNameArr[indexPath.row]
            cell.image.image = UIImage(named: topImgArr[indexPath.row])
            
            return cell
        }else{
            let cell = testCollectionView.dequeueReusableCell(withReuseIdentifier: "testcell", for: indexPath) as! TestCollectionViewCell
            let test = testArr[indexPath.row].tests
            cell.name.text = test?.testName
            let stringRate:String  = String(test!.rate)
            cell.price.text = "PKR \(stringRate)"
            cell.bkVu.layer.borderWidth = 0.7
            cell.bkVu.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            let imgUrl = "\(AppUtils.returnBaseUrl())/\(test?.image ?? "j")".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            cell.img.downloaded(from: imgUrl!)
            cell.testAddBtn.layer.cornerRadius = 15
            cell.testAddBtn.tag = indexPath.row
            cell.testAddBtn.addTarget(self, action: #selector(addTest(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func addTest(sender: UIButton){
        
        var testDic = [String:Any]()
        testDic = [
        "id":String(testArr[sender.tag].id),
        "testName":String(testArr[sender.tag].tests.testName),
        "price":String(testArr[sender.tag].price),
        "imgUrl":String(testArr[sender.tag].tests.image),
        "discount":String(testArr[sender.tag].discount),
        "testCode": String(testArr[sender.tag].tests.testCode)
            ]
        AppUtils.sharedInstance.savetoCart(object: testDic)
        print(testDic)
        i+=1
        btnBarBadge.badgeValue = "\(i)"
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topCollectionView{
            if indexPath.row == 0{
                performSegue(withIdentifier: "toaccount", sender: self)
            }else if indexPath.row == 1{
                performSegue(withIdentifier: "toforums", sender: self)
            }else if indexPath.row == 2{
                performSegue(withIdentifier: "tohealthblogs", sender: self)
            }else{
                
            }
        }else if collectionView == testCollectionView{
            //performSegue(withIdentifier: "maintotestdetail", sender: self)
        }
    }
}

extension ViewController{
    
    func getCommonLabTests(){
        
        let url = "\(AppUtils.returnBaseUrl())/patient/common/labtests"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                let json:JSON = JSON(response.result.value!)
                print(json)
                
                for (_,j) in json{
                    do{
                        let testJson = CommonLabTest(fromJson: j)
                        self.testArr.append(testJson)
                    }
                }
                DispatchQueue.main.async {
                    self.testCollectionView.reloadData()
                }
            }else{
                Utils.showAlert(view: self, message: (response.error?.localizedDescription)!, title: "Error")
                //print(response.error?.localizedDescription as Any)
            }
            
        }
    }
}

extension ViewController{
    
    // AlertController
    func getAlert(message:String?,title:String?){
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


