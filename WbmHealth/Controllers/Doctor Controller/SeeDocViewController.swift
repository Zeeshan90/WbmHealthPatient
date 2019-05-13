//
//  SeeDocViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class SeeDocViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var seeDocTblVu: UITableView!
    var nameArr = ["Doctor","Doctor","Doctor","Doctor","Doctor","Doctor"]
    var imgArr = ["doctor1","doctor1","doctor1","doctor1","doctor1","doctor1"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = seeDocTblVu.dequeueReusableCell(withIdentifier: "doccell", for: indexPath) as! SeeDocTableViewCell
        cell.setData(text: nameArr[indexPath.row], imgg: imgArr[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "todoctors", sender: self)
    }

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
