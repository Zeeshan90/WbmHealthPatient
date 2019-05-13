//
//  leftViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import LGSideMenuController

class LeftViewController: LGSideMenuController, UITableViewDelegate,UITableViewDataSource {

    let mainMenu = AppUtils.returnSideMenu()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "navItem", for: indexPath) as! LeftTableViewCell
        cell.itemLbl.text = mainMenu[indexPath.row].name
         cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainMenu.count
        
    }
    

}
