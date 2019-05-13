//
//  WorkoutViewController.swift
//  WbmHealth
//
//  Created by Muhammad Zeeshan on 28/04/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    

    @IBOutlet weak var workOutCollection: UICollectionView!
    
    var workOutNameArr = ["Shoulder","Stairs","AbDominal","Shoulder","Stairs","AbDominal","Shoulder","Stairs","AbDominal"]
    var workImgArray = ["shoulder","abdominal","shoulder","abdominal","shoulder","abdominal","shoulder","abdominal","shoulder"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workOutNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = workOutCollection.dequeueReusableCell(withReuseIdentifier: "workoutcell", for: indexPath) as! WorkoutCollectionCell
        cell.name.text = workOutNameArr[indexPath.row]
        cell.image.image = UIImage(named: workImgArray[indexPath.row])
        cardView(view: cell.upperVu)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workoutcategory", sender: self)
    }
    /// CardView
    func cardView(view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.cornerRadius = 10
    }
}

extension WorkoutViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let collectionWidth = collectionView.bounds.width
            let collectioHeight = collectionView.bounds.height
            return CGSize(width: collectionWidth/2, height: collectioHeight/2)


    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
