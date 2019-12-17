//
//  ReviewListViewConroller.swift
//  kokopokePJ
//
//  Created by さきちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewListViewConroller: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    let list = ["口コミ1","口コミ2","口コミ3","口コミ4"]
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = list[indexPath.row]
        return cell
    }
    //cellが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "reviewToDetailSegue", sender: self)
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "visitedDetail")
        self.present(menu!,animated: true,completion: nil)
    }
    
}
