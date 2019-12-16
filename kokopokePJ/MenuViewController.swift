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
    var selectedText : String?
    
    let list = ["訪れた場所","行きたい場所","設定"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false,animated: true)
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
            performSegue(withIdentifier: "menuToVisitedSegue", sender: self)
        case (1) :
            //行きたい場所
            performSegue(withIdentifier: "menuToWantSegue", sender: self)
        case (2) :
            //設定
            performSegue(withIdentifier: "menuToSettingSegue", sender: self)
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
