//
//  CarePlanViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/7/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class CarePlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var carePlanTblVu: UITableView!
    let util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carePlanTblVu.dequeueReusableCell(withIdentifier: "careplancell", for: indexPath) as! CarePlanTableViewCell
        util.cardView(view: cell.vu)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 207
    }
   
}
