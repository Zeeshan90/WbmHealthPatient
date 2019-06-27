//
//  SeeADocViewController.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

struct optionStruct {
    var title: String?
    var waitTime: String?
    var certify: String?
}
class SeeADocViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var seeDocTblVu: UITableView!
    var optionArr = [optionStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        optionArr.append(optionStruct(title: "See first available", waitTime: "3-5 min waiting time", certify: "Board certified doctors"))
        optionArr.append(optionStruct(title: "Book a medical visit", waitTime: "Choose your doctor and time", certify: "Board certified doctors"))
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = seeDocTblVu.dequeueReusableCell(withIdentifier: "seedoccell", for: indexPath) as! SeeADocTableViewCell
        
        cell.title.text = optionArr[indexPath.row].title
        cell.waitTimeLbl.text = optionArr[indexPath.row].certify
        cell.certifyLbl.text = optionArr[indexPath.row].waitTime
      Utils.cardView(view: cell.vu)
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
