//
//  SettingPostUserNameViewController.swift
//  kokopokePJ
//
//  Created by しゅん on 2020/02/03.
//  Copyright © 2020 Saki Nakayama. All rights reserved.
//

import UIKit

class SettingPostUserNameViewController: UIViewController {
    
    @IBOutlet weak var editPostUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editPostUserName.text = Params.authorName
        editPostUserName.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        // myTextFieldの入力チェック(文字数チェック)をオブザーバ登録
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textFieldDidChange(notification:)),
                                               name: UITextField.textDidChangeNotification,
                                               object: editPostUserName)
    }
    
    // オブザーバの破棄
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textFieldDidChange(notification: NSNotification) {
        let textField = notification.object as! UITextField
        let nextActionBar = UIBarButtonItem(title: "作成", style: .plain, target: self, action: #selector(loadUi))
        if let _ = textField.text {
            if 0 >= textField.text!.count {
                self.navigationItem.setRightBarButton(nil, animated: true)
            } else {
                if let _ = navigationItem.rightBarButtonItem {
                    //do nothing..
                } else {
                    self.navigationItem.setRightBarButton(nextActionBar, animated: true)
                }
            }
        }
    }
    
    @objc func loadUi(_ selder: UIBarButtonItem) {
        if let name = self.editPostUserName.text {
            registerLocalStorage(name:name)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func registerLocalStorage(name:String) {
        //各項目の値を保存するために、UserDefaultsに値をセットする
        let userDefaults = UserDefaults.standard
        userDefaults.set(name, forKey: "authorName")
        //保存するためにはsynchronizeメソッドを実行する
        userDefaults.synchronize()
        Params.authorName = name
        if name.count == 0 {
            Params.pinTheAuthor = false
        }
        
    }

}
