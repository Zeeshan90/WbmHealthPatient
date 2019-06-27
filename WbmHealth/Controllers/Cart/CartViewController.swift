//
//  CartViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 21/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    

    @IBOutlet weak var tobepaid: UILabel!
    @IBOutlet weak var productTblVu: UITableView!
    @IBOutlet weak var billVu: UIView!
    var util = Utils()
    @IBOutlet weak var noOfProducts: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var totalDiscount: UILabel!
    
    var cart = [LabTests]()
    override func viewDidLoad() {
        super.viewDidLoad()

        cart = AppUtils.sharedInstance.getAllCartProducts()
        Utils.cardView(view: billVu)
        
        noOfProducts.text = "\(cart.count)"
        setAmount()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cart.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTblVu.dequeueReusableCell(withIdentifier: "productcell", for: indexPath) as! CartTableViewCell
        
        let imag = "\(AppUtils.returnBaseUrl())\(cart[indexPath.row].imgUrl ?? "g")"
        cell.setData(name: cart[indexPath.row].testName!, imgUrl: imag, price: cart[indexPath.row].price!)
        return cell
    }
    
    func setAmount(){
    
        var discount = 0
        var paidAmount = 0
        var amount: Int = 0
        for i in cart{
            amount = Int(i.price!)! + amount
            discount = Int(i.discount!)! + discount
            
        }
        totalAmount.text = "\(String(amount))"
        totalDiscount.text = "\(String(discount))"
        paidAmount = amount - discount
        tobepaid.text = "\(paidAmount)"
    }
    
    
    @IBAction func proceedToCheckout(_ sender: Any) {
        
        performSegue(withIdentifier: "tocartdetail", sender: self)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            cart = AppUtils.sharedInstance.deleteCartProduct(index: indexPath.row)
            self.productTblVu.deleteRows(at: [indexPath], with: .automatic)
             noOfProducts.text = "\(cart.count)"
            setAmount()
        }
    }


}
    
