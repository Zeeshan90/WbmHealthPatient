//
//  AppointPendingViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class AppointPendingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var pendingTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pendingTblVu.dequeueReusableCell(withIdentifier: "pendingcell", for: indexPath) as! PendingTableViewCell
        return cell
    }
    

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
