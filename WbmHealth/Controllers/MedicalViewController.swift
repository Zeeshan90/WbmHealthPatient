//
//  MedicalViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class MedicalViewController: UIViewController,UITableViewDelegate
,UITableViewDataSource{
    
    

    @IBOutlet weak var medicalTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = medicalTblVu.dequeueReusableCell(withIdentifier: "medicalcell", for: indexPath) as! MedicalTableViewCell
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if medicalTblVu.cellForRow(at: indexPath)?.accessoryType == UITableViewCell
            .AccessoryType.checkmark{
            medicalTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell
                .AccessoryType.none
        }else{
            medicalTblVu.cellForRow(at: indexPath)?.accessoryType = UITableViewCell
                .AccessoryType.checkmark
        }
    }

}
