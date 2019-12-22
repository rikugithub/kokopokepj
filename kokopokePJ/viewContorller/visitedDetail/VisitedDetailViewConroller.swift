//
//  VisitedDetailViewConroller.swift
//  kokopokePJ
//
//  Created by さきねぇ on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class VisitedDetailViewConroller: UIViewController {
    
    @IBOutlet weak var backToVisitedFromDetail:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToVisitedFromDetail.isUserInteractionEnabled = true
        //bToMenuFromWantがタップされたら呼ばれる
        backToVisitedFromDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "visited")
        self.present(menu!,animated: true,completion: nil)
    }
    
}
