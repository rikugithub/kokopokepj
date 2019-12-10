//
//  topViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/04.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

class topViewController: UIViewController {

    @IBOutlet weak var menuButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.isUserInteractionEnabled = true
       //menuButtonがタップされたら呼ばれる
        menuButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.menuTaped(_:))))
    }
    
    @objc func menuTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "menu")
        self.present(menu!,animated: true,completion: nil)
    }
}
