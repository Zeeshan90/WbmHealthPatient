//
//  DoctorsViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class DoctorsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var docTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = docTblVu.dequeueReusableCell(withIdentifier: "doctorcell", for: indexPath) as! DoctorsTableViewCell
        cell.vu.layer.cornerRadius = 10
        cell.vu.layer.borderColor = #colorLiteral(red: 0.005218341481, green: 0.30667454, blue: 0.4687452316, alpha: 1)
        cell.vu.layer.borderWidth = 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "docdetail", sender: self)
    }
}
