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
    }
    
    menuButton.isUserInteractionEnabled = true
    menuButton.addGestureRecognize(target : self, action : #selector(self.menuTaped(_ :)))
    
    
    @objc func menuTaped(_ sender : UITapGestureRecognizer) {
        let storyboad: UIStoryboard = self.storyboard!
        let top = storyboard.instantiateViewController(identifier: "menu")
        self.present(top,animated: true,completion: nil)
    }
    
    
    
}
  
