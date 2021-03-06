//
//  ViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/02.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //kokopokeロゴ画像設定
        let image = UIImage(named: "whiteLogo")
        topImage.image = image
        
        //起動画面の表示タイマーを2秒に設定
        let _ : Timer = Timer.scheduledTimer(timeInterval:2, target: self, selector: #selector(PhotoReviewController), userInfo: nil, repeats: false)
    }
    //top画面へ遷移
    @objc func PhotoReviewController(timer : Timer) {
        self.performSegue(withIdentifier: "prc", sender: nil)
    }
}


