//
//  WantToGoDetailViewController.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/22.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class WantToGoDetailViewController: UIViewController {
    
    public var area:VisitedPlace!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkReviewListButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "wantDetailToReviewSegue", sender: self)
    }
    
    
    @IBAction func startNaviButtonTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wantDetailToReviewSegue" {
            let nextVC = segue.destination as! ReviewListViewConroller
            nextVC.areaName = area.getName()
        }
    }

}
