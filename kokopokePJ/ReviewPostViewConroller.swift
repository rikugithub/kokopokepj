//
//  ReviewPostViewConroller.swift
//  kokopokePJ
//
//  Created by やまちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewPostViewConroller: UIViewController {

        
    @IBOutlet weak var backToReviewDetailFromReviewPost: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToReviewDetailFromReviewPost.isUserInteractionEnabled = true
        //bToMenuFromWantがタップされたら呼ばれる
        backToReviewDetailFromReviewPost.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "visitedDetail")
        self.present(menu!,animated: true,completion: nil)
    }
    

}
