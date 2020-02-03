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
class SettingTableViewController: UITableViewController {
    
    @IBOutlet var settingTable: UITableView!
    @IBOutlet weak var shareSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTable.delegate = self
        self.settingTable.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // 「口コミ投稿情報」のセクション
            return 2
        case 1 : // 「GPS」のセクション
            return 1
        case 2: //「検索履歴」のセクション
            return 1
        default: // ここが実行されることは無いはず
            return 0
        }
    }

    //cellが選択された時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: // 「口コミ投稿情報」のセクション
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "toPostUserNameEditSegue", sender: nil)
                break
            case 1:
                //do nothing..
                break
            default:
                //do nothing..
                break
            }
        case 1 : // 「GPS」のセクション
            //performSegue(withIdentifier: , sender: )
            break
        case 2: //「検索履歴」のセクション
            //performSegue(withIdentifier: , sender: )
            break
        default: // ここが実行されることは無いはず
            //do nothing
            break
        }
    }
    
}
