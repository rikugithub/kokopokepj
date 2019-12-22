//
//  ReviewDetailViewConroller.swift
//  kokopokePJ
//
//  Created by さっちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewDetailViewConroller: UIViewController {
    
    public var review:Review!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //以下を画面に出力すればOK.
        print(review)
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "reviewList")
        self.present(menu!,animated: true,completion: nil)
    }
    

}
