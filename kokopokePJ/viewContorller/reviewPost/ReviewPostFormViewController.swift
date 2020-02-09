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
    @IBOutlet weak var reviewRating: UITextField!
    @IBOutlet weak var reviewText: UITextView!
    
    var datePicker:UIDatePicker = UIDatePicker()
    var genrePicker:UIPickerView = UIPickerView()
    var whoWithPicker:UIPickerView = UIPickerView()
    var ratingPicker:UIPickerView = UIPickerView()
    
    var alertController: UIAlertController!
    
    public var placeName:String!
    
    var pinTheAuthor:Bool = Params.pinTheAuthor
    
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
    
    let ratingList = [
        "☆☆☆☆☆","★☆☆☆☆","★★☆☆☆","★★★☆☆","★★★★☆","★★★★★"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewText.text = ""
        
        
        authorSettingSwitch.isOn = pinTheAuthor
        // セルを選択不可
        self.tableView.allowsSelection = false
        
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
        
        //評価ピッカーの設定
        reviewRating.borderStyle = UITextField.BorderStyle.none
        ratingPicker.delegate = self
        ratingPicker.dataSource = self
        ratingPicker.tag = 3
        let ratingToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let ratingDoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ratingDone))
        let ratingCancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ratingCancel))
        ratingToolbar.setItems([ratingCancelItem, ratingDoneItem], animated: true)
        self.reviewRating.inputView = ratingPicker
        self.reviewRating.inputAccessoryView = ratingToolbar
        
        imagePicker.delegate = self
        imageClipButton.isUserInteractionEnabled = true
        imageClipButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.addImageButtonTapped(_:))))
    }
    
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
    
    @objc func ratingCancel() {
        self.reviewRating.text = ""
        self.reviewRating.endEditing(true)
    }
    
    @objc func ratingDone() {
        self.reviewRating.endEditing(true)
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
        } else if pickerView.tag == 2 {
            return withList.count
        } else {
            return ratingList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return genreList[row]
        } else if pickerView.tag == 2 {
            return withList[row]
        } else {
            return ratingList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.genreInputFiled.text = genreList[row]
        } else if pickerView.tag == 2{
            self.whoWithInputFiled.text = withList[row]
        } else {
            self.reviewRating.text = ratingList[row]
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
    
    
    @IBAction func postButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "postToConfirmSegue", sender: self)
        let text = reviewText.text!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postToConfirmSegue" {
            let nextVC = segue.destination as! ReviewConfirmViewConroller
            nextVC.image = visitedImageView.image
            
            let review = Review(visitedPlaceName: placeName ,
                                postUserName: postHostName.text!,
                                postUserAge: "",
                                postUserGender: false,
                                visitedTimestamp: "",
                                postTimestamp: "",
                                rating: convertRating(s: reviewRating.text!),
                                visitedPlaceGenre: convertGenre(s: genreInputFiled.text!),
                                withWho: convertWhoWith(s: whoWithInputFiled.text!),
                                //TODO: その他ってどうするの？
                withWhoElse: "",
                imgURL: "",
                reviewContent: reviewText.text,
                memo: reviewText.text)
            nextVC.review = review
        }
    }
    
    func alert(title:String, message:String) {
        alertController = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
    private func convertRating(s:String) -> Int {
        switch s {
        case "☆☆☆☆☆":
            return 0
        case "★☆☆☆☆":
            return 1
        case "★★☆☆☆":
            return 2
        case "★★★☆☆":
            return 3
        case "★★★★☆":
            return 4
        case "★★★★★":
            return 5
        default:
            return 0
        }
    }
    private func convertGenre(s:String) -> Int {
        switch s {
        case " ":
            return 1
        case "飲食":
            return 2
        case "娯楽":
            return 3
        case "ショッピング":
            return 4
        case "交通":
            return 5
        case "生活":
            return 6
        case "ゲーム":
            return 7
        case "その他":
            return 8
        default:
            return 0
        }
    }
    
    
    private func convertWhoWith(s:String) -> Int {
        switch s {
        case " ":
            return 1
        case "１人":
            return 2
        case "家族":
            return 3
        case "恋人":
            return 4
        case "その他":
            return 5
        default:
            return 0
        }
        
    }
    
}
