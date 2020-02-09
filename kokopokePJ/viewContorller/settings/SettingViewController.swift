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
class SettingTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    @IBOutlet var settingTable: UITableView!
    @IBOutlet weak var shareSwitch: UISwitch!
    
    var pinTheAuthor:Bool = Params.pinTheAuthor
    
    //tableViewのバックグラウンドカラー
    public let backGroundColor:UIColor = UIColor(red: 236/255, green: 235/255, blue: 241/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.settingTable.delegate = self
        self.settingTable.dataSource = self
        //背景色を指定
        self.view.backgroundColor = backGroundColor
        
        shareSwitch.addTarget(self, action: #selector(SettingTableViewController.onClickMySwicth(sender:)), for: UIControl.Event.valueChanged)
        shareSwitch.isOn = pinTheAuthor
    }
    
    //Headerの高さ
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //Footerの高さ
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    //Headerが表示される時の処理
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        //Headerのラベルの文字色を設定
        header.textLabel?.textColor = UIColor.gray
        //Headerの背景色を設定
        header.contentView.backgroundColor = backGroundColor
    }
    //Footerが表示される時の処理
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footer = view as? UITableViewHeaderFooterView else { return }
        //Footerのラベルの文字色を設定
        footer.textLabel?.textColor = UIColor.white
        //Footerの背景色を設定
        footer.contentView.backgroundColor = backGroundColor
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
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MenuViewController {
            //各項目の値を保存するために、UserDefaultsに値をセットする
            let userDefaults = UserDefaults.standard
            userDefaults.set(pinTheAuthor, forKey: "pinTheAuthor")
            //保存するためにはsynchronizeメソッドを実行する
            userDefaults.synchronize()
            Params.pinTheAuthor = pinTheAuthor
        }
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
            pinTheAuthor = true
        } else {
            pinTheAuthor = false
        }
    }
    //検索ワードの初期化
    func clearCache() {
        let history = History()
        let userDefaults = UserDefaults.standard
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: history),forKey: "history")
    }
    
}
