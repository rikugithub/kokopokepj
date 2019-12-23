//
//  ReviewPostFormViewController.swift
//  kokopokePJ
//
//  Created by 二川純哉 on 2019/12/20.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
 
class ReviewPostFormViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var evaluationOne: UIImageView!
    @IBOutlet weak var evaluationTwo: UIImageView!
    @IBOutlet weak var evaluationThree: UIImageView!
    @IBOutlet weak var evaluationFour: UIImageView!
    @IBOutlet weak var evaluationFive: UIImageView!
    @IBOutlet weak var evaluationDisplay: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //　画像を定義
    var img1 = UIImage(named:"1")!
    var img2 = UIImage(named:"2")!
    var img3 = UIImage(named:"3")!
    var img4 = UIImage(named:"4")!
    var img5 = UIImage(named:"5")!
    
    // ジャンル内容
    let dataList = [
        "飲食","娯楽","ショッピング","交通",
        "生活","ゲーム","その他"
        
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
    
    // 評価を表示
    @IBAction func evaluationOne(_ sender: UIButton) {
        evaluationDisplay.image = img1
    }
    @IBAction func evaluationTwo(_ sender: UIButton) {
        evaluationDisplay.image = img2
    }
    @IBAction func evaluationThree(_ sender: UIButton) {
        evaluationDisplay.image = img3
    }
    
    @IBAction func evaluationFour(_ sender: UIButton) {
        evaluationDisplay.image = img4
    }
    @IBAction func evaluationFive(_ sender: UIButton) {
        evaluationDisplay.image = img5
    }
    
    @IBAction func postButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "postToConfirmSegue", sender: self)
    }
}
