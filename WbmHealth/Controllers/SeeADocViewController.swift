//
//  SeeADocViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class SeeADocViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var seeDocTblVu: UITableView!
     let util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = seeDocTblVu.dequeueReusableCell(withIdentifier: "seedoccell", for: indexPath) as! SeeADocTableViewCell
        cell.title.text = "Book a mental health session"
        cell.waitTimeLbl.text = "3-4 waiting time"
        cell.certifyLbl.text = "Certified Doctors"
        util.cardView(view: cell.vu)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WbmDefaults.instance.setInt(key: "index", value: indexPath.row)
        performSegue(withIdentifier: "tovisit", sender: self)
    }
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
