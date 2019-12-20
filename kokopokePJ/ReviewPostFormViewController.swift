//
//  ReviewPostFormViewController.swift
//  kokopokePJ
//
//  Created by 二川純哉 on 2019/12/20.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
 
class ReviewPostFormViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    // ジャンル内容
    let dataList = [
        "飲食","娯楽","ショッピング","交通",
        "生活","ポケGO","DQウォーク","その他"
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate設定
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
    }
    
}
