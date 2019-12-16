//
//  menuViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backToTop: UIImageView!
    var selectedText : String?
    
    let list = ["訪れた場所","行きたい場所","設定"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToTop.isUserInteractionEnabled = true
        //backToTopがタップされたら呼ばれる
        backToTop.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        let a: Int = indexPath.row
        
        switch a {
        case (0) :
            //訪れた場所
            let _: UIStoryboard = self.storyboard!
            let visited = storyboard?.instantiateViewController(identifier: "visited")
            self.present(visited!,animated: true,completion: nil)
        case (1) :
            //行きたい場所
            let _: UIStoryboard = self.storyboard!
            let wantToGo = storyboard?.instantiateViewController(identifier: "wantToGo")
            self.present(wantToGo!,animated: true,completion: nil)
        case (2) :
            //設定
            let _: UIStoryboard = self.storyboard!
            let setting = storyboard?.instantiateViewController(identifier: "setting")
            self.present(setting!,animated: true,completion: nil)
        default :
            print("エラー")
        }
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let top = storyboard?.instantiateViewController(identifier: "top")
        self.present(top!,animated: true,completion: nil)
    }
    
    
}
