//
//  vsitedViewContrller.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit
import Firebase

//訪れた場所
class VistedViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    
    var ref:DatabaseReference!
    
    var selectedText : String?
    var visitedPlaces:[VisitedPlace] = []
    var selectedVisitedPlaces:VisitedPlace!
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        loadVisitedData(deviceId: deviceId!, comp: {
            visitedPlaces in
            
            self.visitedPlaces = visitedPlaces
            //くるくる終了
            self.dismissIndicator()
            
            if visitedPlaces.count == 0 {
                self.makeNoneView()
            }
            self.tableView.reloadData()
        })
        //くるくる開始
        startIndicator()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = visitedPlaces[indexPath.row].getName()
        return cell
    }
    
    //cellが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVisitedPlaces = visitedPlaces[indexPath.row]
        performSegue(withIdentifier: "visitedToDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visitedToDetailSegue" {
            //遷移先ViewCntrollerの取得
            let nextView = segue.destination as! VisiteDetailsViewController
            //値の設定
            nextView.visitedPlace = selectedVisitedPlaces
        }
    }
    
    func loadVisitedData(deviceId:String,comp:@escaping([VisitedPlace]) -> Void) {
        var visitedPlaces:[VisitedPlace] = []
        ref = Database.database().reference().child("VisitedPlaces").child(deviceId)
        ref.observe(.value, with: { snapshot in
            if let values = snapshot.value as? [String:[String:Any]] {
                for value in values {
                    let val = value.value
                    let visitedPlace = VisitedPlace(dic: val)
                    visitedPlaces.append(visitedPlace)
                }
            }
            comp(visitedPlaces)
        })
    }
    
    fileprivate func makeNoneView() {
        let groupNoneView = UIView(frame: CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height))
        groupNoneView.backgroundColor = UIColor.white
        let title = UILabel(frame: CGRect(x:self.view.frame.width/2,y: self.view.frame.height/2,width: 250,height:250))
        title.text = "場所が登録されていません"
        title.textAlignment = .center
        title.center = self.view.center
        groupNoneView.addSubview(title)
        self.view.addSubview(groupNoneView)
    }
    
}
