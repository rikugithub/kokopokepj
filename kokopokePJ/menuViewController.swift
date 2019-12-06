//
//  menuViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/06.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class menuViewController: UIViewController  UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
    }
    
    func listTabele(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
        
    func listTable(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
