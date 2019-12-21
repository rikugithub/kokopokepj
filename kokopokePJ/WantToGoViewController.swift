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
    
    //行きたい場所タイトル配列
    var wannaGoPlacesTitle:[String] = []
    //行きたい場所モデル配列
    var wannaGoPlaces:[VisitedPlace] = []
    
    var targetArea:VisitedPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //モデルに設定
        wannaGoPlaces = loadVisitedPlace()!
        wannaGoPlaces.forEach { e in
            wannaGoPlacesTitle.append(e.getName())
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wannaGoPlacesTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = wannaGoPlacesTitle[indexPath.row]
        return cell
    }
    
    //cellが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        targetArea = wannaGoPlaces[indexPath.row]
        performSegue(withIdentifier: "WantToDetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WantToDetailsSegue" {
            let nextVC = segue.destination as! WantToGoDetailViewController
            nextVC.area = targetArea
        }
    }
    
    //ローカルストレージから読み込み
    func loadVisitedPlace() -> [VisitedPlace]?{
        if let loadedData = UserDefaults().data(forKey: "wannaGoPlaces") {
            let wannaGoPlace = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as! [VisitedPlace]
            return wannaGoPlace
        }else {
            return nil
        }
    }
}
