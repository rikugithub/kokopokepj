//
//  WantToGoViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/13.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit

//行きたい場所
class WantToGoViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

      let WantTolist = ["北海道情報専門学校","ラソラ東札幌店","アークス菊水店","つぼ八東札幌店"]
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return WantTolist.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          // セルに表示する値を設定する
          cell.textLabel!.text = WantTolist[indexPath.row]
          return cell
      }
      
      //cellが選択された時の処理
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
          performSegue(withIdentifier: "WantToDetailsSegue", sender: self)
      }
}
