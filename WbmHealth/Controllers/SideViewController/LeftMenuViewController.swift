//
//  LeftMenuViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/26/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import LGSideMenuController

class LeftMenuViewController: LGSideMenuController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var menuTblVu: UITableView!
    let mainMenu = AppUtils.returnSideMenu()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTblVu.dequeueReusableCell(withIdentifier: "navItem", for: indexPath) as! LeftTableViewCell
        cell.itemLbl.text = mainMenu[indexPath.row].name
        cell.itemImg.image = UIImage(named: mainMenu[indexPath.row].image)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(mainMenu[indexPath.row].name)
        let selectedName = mainMenu[indexPath.row].name
        if selectedName == "Home"{
            
        }else if selectedName == "Appoinments"{
            
            performSegue(withIdentifier: "appointtab", sender: self)
        }else if selectedName == "Profile Setting"{
           
        }else if selectedName == "Contact Us"{
            performSegue(withIdentifier: "contactus", sender: self)

        }else if selectedName == "About Us"{
           
        }
        else if selectedName == "WBM Health Service"{
            
        }
        else if selectedName == "Privacy Policy"{
            performSegue(withIdentifier: "privacypolicy", sender: self)
        }else if selectedName == "Logout"{
           WbmDefaults.instance.setString(key: "token", value: "")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "AccountLoginViewController") as! AccountLoginViewController
            self.present(mainViewController, animated: true, completion: nil)
        }else if selectedName == "Share"{
            
        }
    }

}
