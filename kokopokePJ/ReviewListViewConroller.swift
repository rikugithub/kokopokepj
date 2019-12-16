//
//  ReviewListViewConroller.swift
//  kokopokePJ
//
//  Created by さきちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewListViewConroller: UIViewController {

    @IBOutlet weak var backToVisitedDetailFromReview:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToVisitedDetailFromReview.isUserInteractionEnabled = true
        //bToMenuFromWantがタップされたら呼ばれる
        backToVisitedDetailFromReview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "visitedDetail")
        self.present(menu!,animated: true,completion: nil)
    }
    
}
