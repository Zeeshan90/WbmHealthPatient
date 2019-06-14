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
import ProgressHUD

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
    
    @IBOutlet weak var qualVu: UIView!
    @IBOutlet weak var expTblVu: UITableView!
    @IBOutlet weak var qualTblVu: UITableView!
    
    let util = Utils()
    var docBioArr = [DocBio]()
    var lang = [String]()
    var qualArr = [Qualification]()
    var expArr = [ExperienceDetail]()
    var docId: String!
    var patientId: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        let availableClick = UITapGestureRecognizer(target: self, action: #selector(tapOnAvailable))
        availabilityVu.addGestureRecognizer(availableClick)
        util.cardView(view: topVu)
        util.cardView(view: expVu)
        util.cardView(view: langVu)
        util.cardView(view: ratingVu)
        util.cardView(view: serviceVu)
        util.cardView(view: qualVu)
        docImg.layer.cornerRadius = docImg.frame.height/2
        reviewTxtFld.layer.cornerRadius = 10
        reviewTxtFld.layer.borderWidth = 0.6
        getDocData()
        ProgressHUD.show("Loading..")
        ProgressHUD.spinnerColor(#colorLiteral(red: 0.1215686275, green: 0.3019607843, blue: 0.4588235294, alpha: 1))
        patientId = "5c94754e0948dd2edcb4c299"
        AppointmentViewController.request.patientId = patientId
        // Do any additional setup after loading the view.
    }
    
    @objc func tapOnAvailable(){
        performSegue(withIdentifier: "toavailble", sender: self)
    }
    
    @IBAction func subRevBtn(_ sender: Any) {
        submitReview()
    }
    
    func getDocData(){
        
        let docId = WbmDefaults.instance.getString(key: "docId")
        let url = "\(AppUtils.returnBaseUrl())/patient/doctor/\(docId)"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                ProgressHUD.dismiss()
                let json = JSON(response.result.value!)
                print(json)
                
                self.docBioArr.append(DocBio(fromJson: json))
                self.setDetails()
            }else{
                print(response.error as Any)
            }
        }
        
    }
    
    
    func submitReview(){
        ProgressHUD.show()
        let params: [String:Any] = ["patient":patientId,"reviewNo":reviewStar.rating,"comment":reviewTxtFld.text ?? "Very Good Doctor"]
        let url = "\(AppUtils.returnBaseUrl())/patient/review/add/\(docId!)"
        print(url)
        Alamofire.request(url, method: .put, parameters: params).responseJSON{
            
            response in
            if response.result.isSuccess{
                ProgressHUD.dismiss()
                
                self.present(AppUtils.returnToast(string: "Review Submitted"), animated: true)
                self.present(AppUtils.toast(string: "Review"), animated: true)
                print(response.result.value!)
                print("Submitted")
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
            serviceLbl.text = "PKR \(doc.maxfee ?? "1000")"
            lang = doc.language
            qualArr = doc.qualifications
            expArr = doc.experianceArr
            docId = doc.id
        }
        WbmDefaults.instance.setString(key: "docId", value: docId)
        langCollecVu.reloadData()
        qualTblVu.reloadData()
        expTblVu.reloadData()
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

extension DoctorBioViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == expTblVu{
            return expArr.count
        }else{
            return qualArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == expTblVu{
            let cell = expTblVu.dequeueReusableCell(withIdentifier: "experiancecell", for: indexPath) as! ExperianceTableViewCell
            cell.positionLbl.text = expArr[indexPath.row].position
            cell.workLbl.text = expArr[indexPath.row].workPlace
            return cell
        }else{
            let cell = qualTblVu.dequeueReusableCell(withIdentifier: "qualificationcell", for: indexPath) as! QualificationTableViewCell
            cell.instituteLbl.text = qualArr[indexPath.row].institute
            cell.qualificationLbl.text = qualArr[indexPath.row].qualificationName
            cell.specialityLbl.text = qualArr[indexPath.row].qualificationSpeciality
            return cell
        }
    }
    
    
    
}
