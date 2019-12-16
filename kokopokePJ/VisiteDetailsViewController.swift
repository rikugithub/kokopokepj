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
    
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var seeReviewButton: UIButton!
    @IBOutlet weak var PostOrSaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isUserInteractionEnabled = true
       //backButtonnがタップされたら呼ばれる
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    @IBAction func seeReviewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToReviewSegue", sender: self)
    }
    
    @IBAction func PostOrSaveButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToPostSegue", sender: self)
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let visited = storyboard?.instantiateViewController(identifier: "visited")
        self.present(visited!,animated: true,completion: nil)
    }
}
