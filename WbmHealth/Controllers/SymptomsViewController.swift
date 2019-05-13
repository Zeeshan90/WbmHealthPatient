//
//  SymptomsViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class SymptomsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var symptomTblVu: UITableView!
    
    var sectionArr = ["General Symptoms","Head","Neck","Chest"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArr[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = symptomTblVu.dequeueReusableCell(withIdentifier: "symptomcell", for: indexPath) as! SymptomsTableViewCell
        cell.nameLbl.text = sectionArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if symptomTblVu.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            symptomTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }else{
            symptomTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        performSegue(withIdentifier: "tomedical", sender: self)
    }
}
