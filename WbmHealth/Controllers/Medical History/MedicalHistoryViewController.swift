//
//  MedicalHistoryViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/30/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import SwiftChart
class MedicalHistoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var optionCollectionVu: UICollectionView!
    @IBOutlet weak var chart1: Chart!
    @IBOutlet weak var chart3: Chart!
    @IBOutlet weak var chart2: Chart!
    let util = Utils()
    var nameArr = ["Care Plan","Vaccination","Medication","Observation Labortary","Blood Pressure","Blood Glucose","NIR Readings","BMI Reading","Medical Condition"]
    var selected: String = ""
    var imgArr = ["1","2","3","4","5","6","7","8","9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = [
            (x: 0, y: 0),
            (x: 3, y: 2.5),
            (x: 4, y: 2),
            (x: 5, y: 2.3),
            (x: 7, y: 3),
            (x: 8, y: 2.2),
            (x: 9, y: 2.5)
        ]
        let series = ChartSeries(data: data)
        series.area = true
        
        
        // Use `xLabels` to add more labels, even if empty
        chart1.xLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24]
        // Format the labels with a unit
        chart1.xLabelsFormatter = { String(Int(round($1))) + "h" }
        
        chart1.add(series)
        chart2.add(series)
        
        
        
        // Create a new series specifying x and y values
        let data3 = [
            (x: 0, y: 0),
            (x: 1, y: 3.1),
            (x: 4, y: 2),
            (x: 5, y: 4.2),
            (x: 7, y: 5),
            (x: 9, y: 9),
            (x: 10, y: 8)
        ]
        let series3 = ChartSeries(data: data3)
        chart3.add(series3)
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = optionCollectionVu.dequeueReusableCell(withReuseIdentifier: "medhistcell", for: indexPath) as! MedicalHistoryCollectionViewCell
        cell.setdata(name: nameArr[indexPath.row], imag: imgArr[indexPath.row])
        Utils.cardView(view: cell.vu)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        if index == 0{
            selected = "careplan"
             performSegue(withIdentifier: "tocareplan", sender: self)
        }else if index == 1{
            selected = "vaccination"
             performSegue(withIdentifier: "tocareplan", sender: self)
        }else if index == 2{
            selected = "medication"
             performSegue(withIdentifier: "tocareplan", sender: self)
        }
//        let currentItem = optionCollectionVu.cellForItem(at: indexPath) as! MedicalHistoryCollectionViewCell
//        let selectedItem = currentItem.nameLbl.text
//        if selectedItem == "Care Plan"{
//            performSegue(withIdentifier: "tocareplan", sender: self)
//        }else if selectedItem == "Vaccination"{
//            performSegue(withIdentifier: "tocareplan", sender: self)
//        }else if selectedItem == "Medication"{
//            performSegue(withIdentifier: "tocareplan", sender: self)
//        }else{
//
//        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "tocareplan"{
            let vc = segue.destination as! CarePlanViewController
            vc.share = selected
        }
    }
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MedicalHistoryViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = optionCollectionVu.bounds.width
        let collectioHeight = optionCollectionVu.bounds.height
        return CGSize(width: collectionWidth/3, height: collectioHeight/3)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
