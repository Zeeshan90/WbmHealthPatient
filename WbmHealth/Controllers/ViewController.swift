//
//  ViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Foundation

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
    
    @IBOutlet weak var testCollectionView: UICollectionView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    var topNameArr = ["My Accounts","Forums","Emergency","Health Blogs"]
    var topImgArr = ["1","2","3","4"]
    var testArr = ["test1","test2","test3","test4"]
    let util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        util.cardView(view: labortaryVu)
        util.cardView(view: labortaryVu)
        util.cardView(view: medHisVu)
        util.cardView(view: workOutVu)
        util.cardView(view: bmmiCalVu)
        util.cardView(view: healthTipsVu)
        util.cardView(view: appoinmentVu)
        util.cardView(view: seeADocVu)
        util.cardView(view: nearByPharmmancyVu)
        util.cardView(view: nearByHospitalVu)
        util.cardView(view: bottomVu)
        
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
    }

    @objc func tapOnMedHis(){
        performSegue(withIdentifier: "medicalhistory", sender: self)
    }
    @objc func tapOnBmiCal(){
        
    }
    @objc func tapOnHelthTip(){
        
    }
    @objc func tapOnappointment(){
        
    }
    @objc func tapOnseeDoc(){
        performSegue(withIdentifier: "seeDoc", sender: self)
    }
    @objc func tapOnNearPhar(){
        
    }
    @objc func tapOnNearHosp(){
       // performSegue(withIdentifier: "hospital", sender: self)
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
            cell.name.text = testArr[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topCollectionView{
            print(indexPath.row)
        }else if collectionView == testCollectionView{
            performSegue(withIdentifier: "maintotestdetail", sender: self)
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


