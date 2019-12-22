//
//  ReviewDetailViewConroller.swift
//  kokopokePJ
//
//  Created by さっちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewDetailViewConroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "reviewList")
        self.present(menu!,animated: true,completion: nil)
    }
    

}
