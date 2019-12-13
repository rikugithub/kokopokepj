//
//  WantToGoViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/13.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//行きたい場所
class WantToGoViewController: UIViewController{
    

    @IBOutlet weak var backToMenuFromWant: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backToMenuFromWant.isUserInteractionEnabled = true
       //bToMenuFromWantがタップされたら呼ばれる
        backToMenuFromWant.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "menu")
        self.present(menu!,animated: true,completion: nil)
    }
}
