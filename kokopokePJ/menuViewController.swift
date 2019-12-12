//
//  menuViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

class menuViewController: UIViewController {

    @IBOutlet weak var backButton: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isUserInteractionEnabled = true
       //backButtonnがタップされたら呼ばれる
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let top = storyboard?.instantiateViewController(identifier: "top")
        self.present(top!,animated: true,completion: nil)
    }
}
