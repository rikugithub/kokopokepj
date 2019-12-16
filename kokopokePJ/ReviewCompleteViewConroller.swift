//
//  ReviewCompleteViewConroller.swift
//  kokopokePJ
//
//  Created by 山中さん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewCompleteViewConroller: UIViewController {

    @IBOutlet weak var backToReviewCompleteFromReviewPost:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToReviewCompleteFromReviewPost.isUserInteractionEnabled = true
        //bToMenuFromWantがタップされたら呼ばれる
        backToReviewCompleteFromReviewPost.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "reviewConfirm")
        self.present(menu!,animated: true,completion: nil)
    }
    
}
