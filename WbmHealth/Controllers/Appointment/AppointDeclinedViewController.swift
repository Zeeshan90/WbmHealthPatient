//
//  AppointDeclinedViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class AppointDeclinedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var declinedTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = declinedTblVu.dequeueReusableCell(withIdentifier: "declinecell", for: indexPath) as! DeclinedTableViewCell
        return cell
    }
    

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
