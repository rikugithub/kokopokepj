//
//  ReviewConfirmViewConroller.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewConfirmViewConroller: UIViewController {

    @IBOutlet weak var backToReviewPostFromReviewConfirm:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToReviewPostFromReviewConfirm.isUserInteractionEnabled = true
        //bToMenuFromWantがタップされたら呼ばれる
        backToReviewPostFromReviewConfirm.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "reviewPost")
        self.present(menu!,animated: true,completion: nil)
    }
    
}
