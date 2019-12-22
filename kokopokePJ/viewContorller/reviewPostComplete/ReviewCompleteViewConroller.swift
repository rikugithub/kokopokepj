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
    
    
    //    func addDB(vPN:String,pUN:String,pUA:String,pUG:Bool,vT:Date,pT:Date,vPG:Int,wW:Int,wWE:String,iURL:String,rC:String,memo:String) {
    //        ref = Database.database().reference();
    //        let review = Review(vPN: vPN, pUN: pUN, pUA: pUA, pUG: pUG, vT: vT, pT: pT, vPG: vPG, wW: wW, wWE: wWE, iURL: iURL, rC: rC, memo: memo)
    //        let newRf = ref.child("reviews").child(vPN).childByAutoId()
    //        newRf.setValue(review.toDictionary())
    //    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "reviewConfirm")
        self.present(menu!,animated: true,completion: nil)
    }
    
}
