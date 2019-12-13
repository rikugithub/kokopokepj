//
//  settingViewController.swift
//  kokopokePJ
//
//  Created by 二川純哉 on 2019/12/06.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//訪れた場所
class SettingViewController: UIViewController{
    
    @IBOutlet weak var backToMenuFromSetting: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToMenuFromSetting.isUserInteractionEnabled = true
       //bToMenuFromSettingがタップされたら呼ばれる
        backToMenuFromSetting.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "menu")
        self.present(menu!,animated: true,completion: nil)
    }
}
