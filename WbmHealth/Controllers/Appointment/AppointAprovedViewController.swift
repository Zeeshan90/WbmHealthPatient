//
//  AppointAprovedViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class AppointAprovedViewController: UIViewController {
  
    

    @IBOutlet weak var aprrovedAppointTblVu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
