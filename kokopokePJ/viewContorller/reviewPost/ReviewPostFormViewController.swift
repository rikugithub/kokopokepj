//
//  ReviewPostFormViewController.swift
//  kokopokePJ
//
//  Created by 二川純哉 on 2019/12/20.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import Firebase

class ReviewPostFormViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var reviewShareSwitch: UISwitch!
    @IBOutlet weak var authorSettingSwitch: UISwitch!
    @IBOutlet weak var postHostName: UITextField!
    @IBOutlet weak var visitedDateInputFiled: UITextField!
    @IBOutlet weak var genreInputFiled: UITextField!
    @IBOutlet weak var whoWithInputFiled: UITextField!
    @IBOutlet weak var imageClipButton: UIImageView!
    @IBOutlet weak var visitedImageView: UIImageView!
    @IBOutlet weak var evaluationDisplay: UIImageView!
    @IBOutlet weak var evaluationOne: UIButton!
    @IBOutlet weak var evaluationTwo: UIButton!
    @IBOutlet weak var evaluationThree: UIButton!
    @IBOutlet weak var evaluationFour: UIButton!
    @IBOutlet weak var evaluationFive: UIButton!
    @IBOutlet weak var reviewText: UITextView!
    
    var datePicker:UIDatePicker = UIDatePicker()
    var genrePicker:UIPickerView = UIPickerView()
    var whoWithPicker:UIPickerView = UIPickerView()
    
    var pinTheAuthor:Bool = Params.pinTheAuthor
    
    //　画像を定義
    var img1 = UIImage(named:"1")!
    var img2 = UIImage(named:"2")!
    var img3 = UIImage(named:"3")!
    var img4 = UIImage(named:"4")!
    var img5 = UIImage(named:"5")!
    var evaluationString:String = ""
    
    let imagePicker = UIImagePickerController()
    
    let storage = Storage.storage()
    // ジャンル内容
    let genreList = [
        " ","飲食","娯楽","ショッピング","交通",
        "生活","ゲーム","その他"
        
    ]
    
    let withList = [
        " ","１人","家族","友達","恋人","その他"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewText.text = ""
        
        authorSettingSwitch.isOn = pinTheAuthor
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        visitedDateInputFiled.inputView = datePicker
        // 開始DatePickerの生成
        let startToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let startSpacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let startDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(start))
        startToolbar.setItems([startSpacelItem, startDoneItem], animated: true)
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        visitedDateInputFiled.inputView = datePicker
        visitedDateInputFiled.inputAccessoryView = startToolbar
        
        
        //ジャンルピッカーの設定
        genrePicker.delegate = self
        genrePicker.dataSource = self
        genrePicker.tag = 1
        let genreToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let genreDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(genreDone))
        let genreCancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(genreCancel))
        genreToolbar.setItems([genreCancelItem, genreDoneItem], animated: true)
        self.genreInputFiled.inputView = genrePicker
        self.genreInputFiled.inputAccessoryView = genreToolbar
        
        //誰と訪れたピッカーの設定
        whoWithPicker.delegate = self
        whoWithPicker.dataSource = self
        whoWithPicker.tag = 2
        let whoWithToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let whoWithDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(whoWithDone))
        let whoWithCancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(whoWithCancel))
        whoWithToolbar.setItems([whoWithCancelItem, whoWithDoneItem], animated: true)
        self.whoWithInputFiled.inputView = whoWithPicker
        self.whoWithInputFiled.inputAccessoryView = whoWithToolbar
        
        imagePicker.delegate = self
        imageClipButton.isUserInteractionEnabled = true
        imageClipButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addImageButtonTapped(_:))))
    }
    
    
    //       if let remoteUrl = params.photoURL {
    //         do {
    //           let url = URL(string: remoteUrl.absoluteString)
    //           let data = try Data(contentsOf: url!)
    //           self.myProfileImg.image = UIImage(data: data)
    //         } catch {
    //           print(error)
    //         }
    //       }
    
    @objc func addImageButtonTapped(_ sender : UITapGestureRecognizer) {
        imagePicker.allowsEditing = true //画像の切り抜きが出来るようになります。
        imagePicker.sourceType = .photoLibrary //画像ライブラリを呼び出します
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            visitedImageView.contentMode = .scaleAspectFit
            visitedImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func genreCancel() {
        self.genreInputFiled.text = ""
        self.genreInputFiled.endEditing(true)
    }
    
    @objc func genreDone() {
        self.genreInputFiled.endEditing(true)
    }
    
    @objc func whoWithCancel() {
        self.whoWithInputFiled.text = ""
        self.whoWithInputFiled.endEditing(true)
    }
    
    @objc func whoWithDone() {
        self.whoWithInputFiled.endEditing(true)
    }
    
    @objc func start() {
        visitedDateInputFiled.endEditing(true)
        let startDate = dateFormat()
        visitedDateInputFiled.text = startDate
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return genreList.count
        } else {
            return withList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return genreList[row]
        } else {
            return withList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.genreInputFiled.text = genreList[row]
        } else {
            self.whoWithInputFiled.text = withList[row]
        }
    }
    
    private func dateFormat() -> String {
        // 日付のフォーマット
        let formatter = DateFormatter()
        //“yyyy年MM月dd日“を”yyyy/MM/dd”したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        return formatter.string(from: datePicker.date)
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
        let text = reviewText.text!
        let result = ProfanityFilter.cleanUp(text)
        print(result)
    }
    
    private func checkEvalution() {
        switch evaluationDisplay.image {
        case img1:
            evaluationString = "★☆☆☆☆"
            break
        case img2:
            evaluationString = "★★☆☆☆"
            break
        case img3:
            evaluationString = "★★★☆☆"
            break
        case img4:
            evaluationString = "★★★★☆"
            break
        case img5:
            evaluationString = "★★★★★"
            break
        default:
            evaluationString = "☆☆☆☆☆"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        checkEvalution()
        //各項目の値を保存するために、UserDefaultsに値をセットする
        let userDefaults = UserDefaults.standard
        userDefaults.set(pinTheAuthor, forKey: "pinTheAuthor")
        //保存するためにはsynchronizeメソッドを実行する
        userDefaults.synchronize()
        Params.pinTheAuthor = pinTheAuthor
        
        if segue.identifier == "postToConfirmSegue" {
            let nextVC = segue.destination as! ReviewConfirmViewConroller
            if let postHostName = postHostName.text {
                nextVC.postHostText = postHostName
            }
            if let visitedDate = visitedDateInputFiled.text {
                nextVC.visitedDayText = visitedDate
            }
            nextVC.evaluationText = evaluationString
            if let genre = genreInputFiled.text {
                nextVC.genreText = genre
            }
            if let whoWith = whoWithInputFiled.text {
                nextVC.withHumanText = whoWith
            }
            if let visitedImage = visitedImageView.image {
                nextVC.imageViewImg = visitedImage
            }
            
            if let reviewText = reviewText.text {
                nextVC.reviewText = reviewText
                
            }
        }
    }
}
