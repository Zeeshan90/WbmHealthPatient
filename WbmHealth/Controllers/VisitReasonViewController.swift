//
//  VisitReasonViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class VisitReasonViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var reasonTblVu: UITableView!
    @IBOutlet weak var searchVu: UISearchBar!
    let util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVu.showsCancelButton = true
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reasonTblVu.dequeueReusableCell(withIdentifier: "visitreasoncell", for: indexPath) as! VisitReasonTableViewCell
        cell.nameLbl.text = "Cough"
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
}
