//
//  LocationInforViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/17.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    var address = String()
    @IBOutlet weak var selectLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        //受け取った値を代入
        selectLocationLabel.text = address
    }
    
}
