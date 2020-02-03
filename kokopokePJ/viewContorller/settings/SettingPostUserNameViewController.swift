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
//        createGroup(comp: {
//            //くるくる終了
//            self.dismissIndicator()
//        })
        //くるくる開始
        startIndicator()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
