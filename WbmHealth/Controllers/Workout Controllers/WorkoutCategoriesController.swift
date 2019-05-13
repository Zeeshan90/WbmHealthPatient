//
//  WorkoutCategoriesController.swift
//  WbmHealth
//
//  Created by WBM on 4/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit

class WorkoutCategoriesController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
  
    

    @IBOutlet weak var workOutCollection: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var upperVu: UIView!
    
    var workNameArr = ["Crossbody Crunches","Crunches","Crunches with legs on ball","Decline Crunches","Abdominal Crunches on ball"]
    var workImgArr = ["cross_body_crunch_1","crunches_1","crunches_1","crunches_1","crunches_1"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardView(view: upperVu)
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = workOutCollection.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! WorkoutCategoryCollectionCell
        cell.name.text = workNameArr[indexPath.row]
        cell.img.image = UIImage(named: workImgArr[indexPath.row])
        cardView(view: cell.cardVu)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workoutdetail", sender: self)
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

extension WorkoutCategoriesController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        let collectioHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth/3, height: collectioHeight/2)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


