//
//  ReviewConfirmViewConroller.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import Firebase

class ReviewConfirmViewConroller: UITableViewController {
    
    @IBOutlet weak var postHostLabel: UILabel!
    @IBOutlet weak var visitedDay: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var withHuman: UILabel!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    
    public var review:Review!
    let storage = Storage.storage()
    var ref = Database.database().reference();
    
    public var image:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postHostLabel.text = review.getPostUserName()
        visitedDay.text = review.getVisitedTimestamp()
        evaluationLabel.text = review.getRating()
        genreLabel.text = review.getVisitedPlaceGenre()
        withHuman.text = review.getWithWho()
        imageViewTwo.image = image
        reviewLabel.text = review.getReviewContent()
        
    }
    
    @IBAction func postTouch(_ sender: Any) {
        upload(comp: { url in
            if let u = url {
                self.review.setImgURL(imgURL: u.absoluteString)
                let newRf = self.ref.child("reviews").child(self.review.getVisitedPlaceName()).childByAutoId()
                newRf.setValue(self.review.toDictionary())
                self.dispSwitchAlart()
            } else {
                self.dispErrorAlart()
            }
            //くるくる終了
            self.dismissIndicator()
        })
        //くるくる終了
        self.dismissIndicator()
    }
    
    private func upload(comp:@escaping(URL?) -> Void) {
        let date = NSDate()
        let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("images").child("review").child("\(currentTimeStampInSecond).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        if let uploadData = self.imageViewTwo.image?.jpegData(compressionQuality: 0.9) {
            storageRef.putData(uploadData, metadata: metaData) { (metadata , error) in
                if let e = error {
                    print("error: \(e.localizedDescription)")
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if let e = error {
                        print("error: \(e.localizedDescription)")
                        comp(nil)
                    }
                    if let u = url {
                        print("url: \(u.absoluteString)")
                        comp(u)
                    }
                })
            }
        }
    }
    
    private func dispSwitchAlart() {
        let alert: UIAlertController = UIAlertController(title: nil, message: "投稿完了", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title:"閉じる" , style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func dispErrorAlart() {
        let alert: UIAlertController = UIAlertController(title: nil, message: "投稿に失敗しました", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title:"閉じる" , style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) -> Void in
            //do nothing..
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

