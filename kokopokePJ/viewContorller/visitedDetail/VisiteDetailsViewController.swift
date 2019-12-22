//
//  visiteDetailsViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//訪れた場所の詳しい情報
class VisiteDetailsViewController: UIViewController{
    
    @IBOutlet weak var seeReviewButton: UIButton!
    @IBOutlet weak var PostOrSaveButton: UIButton!
    
    public var visitedPlace:VisitedPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func seeReviewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToReviewSegue", sender: self)
    }
    
    @IBAction func PostOrSaveButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToPostSegue", sender: self)
    }
    
    //segue遷移直前に実行される処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToReviewSegue" {
            let nextVC = segue.destination as! ReviewListViewConroller
            nextVC.areaName = visitedPlace.getName()
        }
    }
}
