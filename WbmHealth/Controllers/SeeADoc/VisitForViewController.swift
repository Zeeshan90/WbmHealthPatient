//
//  VisitForViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class VisitForViewController: UIViewController {

    
    @IBOutlet weak var childImg: UIImageView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var vu1: UIView!
    @IBOutlet weak var vu2: UIView!
    @IBOutlet weak var vu3: UIView!
    
    let util = Utils()
    override func viewDidLoad() {
        super.viewDidLoad()
        util.cardView(view: vu1)
        util.cardView(view: vu2)
        util.cardView(view: vu3)
        let profileClick = UITapGestureRecognizer(target: self, action: #selector(tapOnProfile))
        vu1.addGestureRecognizer(profileClick)
        let childClick = UITapGestureRecognizer(target: self, action: #selector(tapOnChild))
        vu2.addGestureRecognizer(childClick)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapOnProfile(){
        let clickedIndex = WbmDefaults.instance.getInt(key: "index")
        if clickedIndex == 0{
           performSegue(withIdentifier: "tovisitreason", sender: self)
        }else if clickedIndex == 1{
            performSegue(withIdentifier: "medicalvisit", sender: self)
        }
        
    }
    @objc func tapOnChild(){
        performSegue(withIdentifier: "addchild", sender: self)
    }
   

}
