//
//  DocDetailViewController.swift
//  WbmHealth
//
//  Created by WBM on 4/30/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift
class DocDetailViewController: UIViewController {

    @IBOutlet weak var videoVu: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.youtube.com/watch?v=Y_FDU4-lSDc")
        videoVu.loadVideoURL(url!)
        // Do any additional setup after loading the view.
    }
    

    

}
