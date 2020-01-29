//
//  settingViewController.swift
//  kokopokePJ
//
//  Created by 二川純哉 on 2019/12/06.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//設定
class SettingTableViewController: UIViewController, UITableViewDataSource{

    
    @IBOutlet weak var postNameSetting: UITableViewCell!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var shareSwitch: UISwitch!
    @IBOutlet weak var GPSSetting: UIView!
    @IBOutlet weak var GPSsettingLabel: UILabel!
    @IBOutlet weak var searchHistoryClear: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    //セルの中身設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "aaaa"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // 「口コミ投稿情報」のセクション
            return 2
        case 1 : // 「GPS」のセクション
            return 2
        case 2: //「検索履歴」のセクション
            return 1
        default: // ここが実行されることは無いはず
          return 0
        }
    }
    
    //cellが選択された時の処理
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     }
    
}
