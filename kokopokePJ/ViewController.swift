//
//  ViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/02.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "whiteLogo")
        topImage.image = image
        
        let _ : Timer = Timer.scheduledTimer(timeInterval:2, target: self, selector: #selector(pageTransition), userInfo: nil, repeats: false)
        
    }
    @objc func pageTransition(timer : Timer) {
        print("hello!")
        let storyboard: UIStoryboard = self.storyboard!
        let top = storyboard.instantiateViewController(identifier: "top")
        self.present(top,animated: false,completion: nil)
    }
}

