//
//  ReviewListViewConroller.swift
//  kokopokePJ
//
//  Created by さきちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import Firebase

class ReviewListViewConroller: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var tableView:UITableView!
    
    public var areaName:String = ""
    var ref: DatabaseReference!
    var reviews:[Review] = []
    var target:Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference().child("reviews").child(areaName)
        
        ref.observe(.value, with: { snapshot in
            if let values = snapshot.value as? [String:[String:Any]] {
                for value in values {
                    let val = value.value
                    let review = Review(dic: val)
                    self.reviews.append(review)
                }
                //API通信が完了時にテーブルをリロード
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    //cellの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! ReviewTableViewCell
        // セルに表示する値を設定する
        cell.postUserName.text = reviews[indexPath.row].getPostUserName()
        cell.postDateLabel.text = reviews[indexPath.row].getPostTimestamp()
        cell.rating.text = reviews[indexPath.row].getWithWho().description
        cell.postContent.text = reviews[indexPath.row].getReviewContent()
        return cell
    }
    //cellが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        target = reviews[indexPath.row]
        performSegue(withIdentifier: "reviewToDetailSegue", sender: self)
    }
    
    //segue遷移直前に実行される処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewToDetailSegue" {
            let nextVC = segue.destination as! ReviewDetailViewConroller
            nextVC.review = target
        }
    }
    
    private func convertDateToString(d:Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return f.string(from: d)
    }
}
