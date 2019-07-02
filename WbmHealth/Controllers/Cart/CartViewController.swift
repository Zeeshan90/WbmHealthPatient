//
//  CartViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 21/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
 
    

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
            
            //Create the alert controller and actions
            let alert = UIAlertController(title: "Are you Sure?", message: "", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                DispatchQueue.main.async {
                    self.cart = AppUtils.sharedInstance.deleteCartProduct(index: indexPath.row)
                    self.productTblVu.deleteRows(at: [indexPath], with: .automatic)
                    self.self.noOfProducts.text = "\(self.cart.count)"
                    self.setAmount()
                }
            }
            
            //Add the actions to the alert controller
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            //Present the alert controller
            present(alert, animated: true, completion: nil)
            
        }
    }
    
//    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
//    {
//        var strText: String? = textField.text
//        if strText == nil {
//            strText = ""
//        }
//        strText = strText?.stringByReplacingOccurrencesOfString("-", withString:"")
//        if strText!.characters.count > 1 && strText!.characters.count % 4 == 0 && string != "" {
//            textField.text = "\(textField.text!)-\(string)"
//            return false
//        }
//        
//        return true
//    }

  

}
    
