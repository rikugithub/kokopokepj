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
    
    var pinTheAuthor:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTable.delegate = self
        self.settingTable.dataSource = self
        
        shareSwitch.addTarget(self, action: #selector(SettingTableViewController.onClickMySwicth(sender:)), for: UIControl.Event.valueChanged)
        shareSwitch.isOn = pinTheAuthor
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
                //GPSの切り替え
                break
            default:
                //do nothing..
                break
            }
        case 1 : // 「GPS」のセクション
            osSettingScheme()
            break
        case 2: //「検索履歴」のセクション
            dispCacheCleanAlart()
            break
        default: // ここが実行されることは無いはず
            //do nothing
            break
        }
        settingTable.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    private func osSettingScheme() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //各項目の値を保存するために、UserDefaultsに値をセットする
        let userDefaults = UserDefaults.standard
        userDefaults.set(pinTheAuthor, forKey: "pinTheAuthor")
        //保存するためにはsynchronizeメソッドを実行する
        userDefaults.synchronize()
        Params.pinTheAuthor = pinTheAuthor
    }
    
    private func dispCacheCleanAlart() {
    let alert: UIAlertController = UIAlertController(title: "確認", message: "本当によろしいですか\n復元することはできません", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title:"OK" , style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            self.clearCache()
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func dispSwitchAlart() {
        let alert: UIAlertController = UIAlertController(title: nil, message: "投稿者名を入力してください", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title:"閉じる" , style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            self.shareSwitch.isOn = false
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    // スイッチが切り替わるときに呼ばれるメソッド
    @objc func onClickMySwicth(sender: UISwitch){
        if sender.isOn {
            //オン
            if Params.authorName == "" {
                dispSwitchAlart()
            }
        }
    }
    //検索ワードの初期化
    func clearCache() {
        let history = History()
        let userDefaults = UserDefaults.standard
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: history),forKey: "history")
    }
    
}
