//
//  DoctorBioViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/13/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Cosmos
class DoctorBioViewController: UIViewController {

    @IBOutlet weak var serviceVu: UIView!
    @IBOutlet weak var ratingVu: UIView!
    @IBOutlet weak var langVu: UIView!
    @IBOutlet weak var expVu: UIView!
    @IBOutlet weak var topVu: UIView!
    @IBOutlet weak var availabilityVu: UIView!
    @IBOutlet weak var docImg: UIImageView!
    @IBOutlet weak var docNameLbl: UILabel!
    @IBOutlet weak var backGroundLbl: UILabel!
    
    @IBOutlet weak var reviewStar: CosmosView!
    @IBOutlet weak var reviewTxtFld: UITextField!
    @IBOutlet weak var serviceLbl: UILabel!
    @IBOutlet weak var langCollecVu: UICollectionView!
    let util = Utils()
    var docBioArr = [DocBio]()
    var lang = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let availableClick = UITapGestureRecognizer(target: self, action: #selector(tapOnAvailable))
        availabilityVu.addGestureRecognizer(availableClick)
        util.cardView(view: topVu)
        util.cardView(view: expVu)
        util.cardView(view: langVu)
        util.cardView(view: ratingVu)
        util.cardView(view: serviceVu)
        docImg.layer.cornerRadius = docImg.frame.height/2
        reviewTxtFld.layer.cornerRadius = 10
        getDocData()
        docImg.showSkeleton()
        // Do any additional setup after loading the view.
    }
    
    @objc func tapOnAvailable(){
        performSegue(withIdentifier: "toavailble", sender: self)
    }
    
    func getDocData(){
        
        let docId = WbmDefaults.instance.getString(key: "docId")
        let url = "\(AppUtils.returnBaseUrl())/patient/doctor/\(docId)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let json = JSON(response.result.value!)
                print(json)
                
                self.docBioArr.append(DocBio(fromJson: json))
                self.setDetails()
            }else{
                print(response.error as Any)
            }
        }
        
    }
    
    func setDetails(){
        
        for doc in docBioArr{
             docImg.downloaded(from: "\(AppUtils.returnBaseUrl())\(doc.photo!)")
            docNameLbl.text = doc.doctorName
            backGroundLbl.text = doc.aboutme
            serviceLbl.text = "PKR \(doc.maxfee ?? "100")"
            lang = doc.language
        }
        langCollecVu.reloadData()
    }

}

extension DoctorBioViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lang.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = langCollecVu.dequeueReusableCell(withReuseIdentifier: "languagecell", for: indexPath) as! LanguageCollectionViewCell
        cell.vu.layer.cornerRadius = cell.vu.frame.height/2
        cell.vu.layer.shadowColor = UIColor.gray.cgColor
        cell.vu.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.vu.layer.shadowRadius = 12.0
        cell.vu.layer.shadowOpacity = 0.7
        cell.vu.layer.borderWidth = 1
        cell.vu.layer.borderColor = #colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1)
        
        cell.nameLbl.text = lang[indexPath.row]
        return cell
    }
    
    
    
    
}
