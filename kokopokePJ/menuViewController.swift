//
//  menuViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/06.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class menuViewController: UIViewController /*,UITableViewDelegate, UITableViewDataSource*/ {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 各セルを生成し返却
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "あいうえお"
        return cell
    }
    
}
