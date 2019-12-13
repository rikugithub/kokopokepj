//
//  vsitedViewContrller.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//訪れた場所
class VistedViewController: UIViewController{
    
    @IBOutlet weak var backToMenuFromVisited: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToMenuFromVisited.isUserInteractionEnabled = true
       //bToMenuFromvisitedがタップされたら呼ばれる
        backToMenuFromVisited.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "menu")
        self.present(menu!,animated: true,completion: nil)
    }
}
