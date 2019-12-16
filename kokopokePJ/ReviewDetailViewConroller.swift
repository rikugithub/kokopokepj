//
//  ReviewDetailViewConroller.swift
//  kokopokePJ
//
//  Created by さっちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewDetailViewConroller: UIViewController {

    @IBOutlet weak var backToReviewListFromReviewDetail:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToReviewListFromReviewDetail.isUserInteractionEnabled = true
        //bToMenuFromWantがタップされたら呼ばれる
        backToReviewListFromReviewDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "reviewList")
        self.present(menu!,animated: true,completion: nil)
    }
    

}
