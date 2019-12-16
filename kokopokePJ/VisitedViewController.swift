//
//  vsitedViewContrller.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//訪れた場所
class VistedViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
    var selectedText : String?
    
    @IBOutlet weak var tableView:UITableView!
    
    let list = ["北海道情報専門学校","ラソラ東札幌店","アークス菊水店","つぼ八東札幌店"]
    
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
  
        let _: UIStoryboard = self.storyboard!
        let visited = storyboard?.instantiateViewController(identifier: "visitedDetail")
        self.present(visited!,animated: true,completion: nil)
    }
    
    
    
    
    @IBOutlet weak var backToMenuFromVisited: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.delegate = self
        //tableView.dataSource = self
        backToMenuFromVisited.isUserInteractionEnabled = true
       //bToMenuFromvisitedがタップされたら呼ばれる
        backToMenuFromVisited.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backTaped(_:))))
    }
    
    
    @objc func backTaped(_ sender : UITapGestureRecognizer) {
        let _: UIStoryboard = self.storyboard!
        let menu = storyboard?.instantiateViewController(identifier: "menu")
        self.present(menu!,animated: true,completion: nil)
    }
}
