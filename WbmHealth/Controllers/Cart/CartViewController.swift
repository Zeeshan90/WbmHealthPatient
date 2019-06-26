//
//  CartViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 21/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    

    @IBOutlet weak var productTblVu: UITableView!
    @IBOutlet weak var billVu: UIView!
    var util = Utils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        util.cardView(view: billVu)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTblVu.dequeueReusableCell(withIdentifier: "productcell", for: indexPath) as! CartTableViewCell
        return cell
    }
    @IBAction func proceedToCheckout(_ sender: Any) {
        
        performSegue(withIdentifier: "tocartdetail", sender: self)
    }
    
}
