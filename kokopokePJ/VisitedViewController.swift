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
    
    var wannaGoPlacesTitle:[String] = []
    var wannaGoPlaces:[VisitedPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        performSegue(withIdentifier: "visitedToDetailSegue", sender: self)
    }
    
    func loadVisitedPlace() -> [VisitedPlace]?{
            if let loadedData = UserDefaults().data(forKey: "wannaGoPlaces") {
                let wannaGoPlace = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as! [VisitedPlace]
                return wannaGoPlace
            }else {
                return nil
            }
    }
}
