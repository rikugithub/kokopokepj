//
//  topViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/04.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Firebase

class TopViewController: UIViewController,UISearchBarDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var MapView: MKMapView!
    @IBOutlet var LongPressGesRec: UILongPressGestureRecognizer!
    @IBOutlet weak var menuButton: UIImageView!
    @IBOutlet weak var searchedView: UIView!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var searchView: UIView!
    //DBコネクション
    public var ref:DatabaseReference!
    
    //ローカルストレージ
    public let userDefaults = UserDefaults.standard
    
    //位置情報コントローラー
    var locManager: CLLocationManager!
    
    //ピン
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    //検索履歴テーブルビュー
    var tableView: UITableView?
    
    //履歴セクション名
    let sectionTitle = ["今日","昨日","今週"]
    
    //検索後ナビゲーションビュー
    var searchedPlace:VisitedPlace?
    
    //ストレージ保存用の行きたい場所モデル
    var wannaGoPlaces:[VisitedPlace] = []
    
    //検索履歴モデル
    var history:History!
    
    var a: String?
    
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.searchedView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ステータスバーのデザイン設定
        let statusBar = UIView(frame:CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 20.0))
        statusBar.backgroundColor = UIColor.init(red:45/255,green:61/255, blue: 255/255, alpha: 90/100)
        view.addSubview(statusBar)
        
        //ストレージに保存
        userDefaults.register(defaults: ["wannaGoPlaces": [wannaGoPlaces]])

        //ナビゲーションバーの非表示
        navigationController?.setNavigationBarHidden(true, animated: true)
        menuButton.isUserInteractionEnabled = true
        
        //menuButtonがタップされたら呼ばれる
        menuButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.menuTaped(_:))))
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.backgroundImage = UIImage()
        
        //位置情報を初期化
        initMap()
        locManager = CLLocationManager()
        locManager.delegate = self
        
        // 位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 座標の表示
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
        }
        
        //tableviewの位置を自動調整
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let searchHeight = searchView.bounds.height
        let y = statusBarHeight + searchHeight
        
        self.tableView = {
            let tableView = UITableView(frame: CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2), style: .plain)
            tableView.autoresizingMask = [
                .flexibleWidth,
                .flexibleHeight
            ]
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "history")
            self.view.addSubview(tableView)
            return tableView
        }()
        
        self.view.sendSubviewToBack(self.tableView!)
        
        //検索時メニューバーの設定
        let height = self.view.bounds.height/4
        let width = self.view.bounds.width
        searchedView.frame = CGRect(x: 0, y: self.view.bounds.height - height, width: width, height: height)
        searchedView.backgroundColor = UIColor.white
        self.searchedView.isHidden = true
        
        history = loadHistory()
    }

    //シングルタップによる入力解除の処理
    @objc func singleTap() {
        searchBar.endEditing(true)
        self.searchBarTextDidEndEditing(_ : searchBar)
        self.view.sendSubviewToBack(self.tableView!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    //1セクションごとに表示する行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO:表示件数の制限
        switch section {
        case 0:
            return history.getTodayHistoryWord().count
        case 1:
            return history.getYesHistoryWord().count
        case 2:
            return history.getLastWeekHistoryWord().count
        default:
            return 0
        }
    }
    
    //セルの中身設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath)
        cell.textLabel!.text = sortHistoryWord(indexPath: indexPath)
        return cell
    }
    
    //セクションタイトルを返す。履歴がなかったら何も表示しない
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //検索ボタンタップ時の処理
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.bringSubviewToFront(self.tableView!)
        searchBar.showsCancelButton = true
    }

    //cellが選択された時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        singleTap()
        let word = sortHistoryWord(indexPath: indexPath)
        mapSearch(address: word)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func sortHistoryWord(indexPath:IndexPath) -> String {
        switch indexPath.section {
        case 0:
            //今日
            let model = history.getTodayHistoryWord()[indexPath.row]
            return model.getWord()
        case 1:
            //昨日
            let model = history.getYesHistoryWord()[indexPath.row]
            return model.getWord()
        case 2:
            //一週間前
            let model = history.getLastWeekHistoryWord()[indexPath.row]
            return model.getWord()
        default:
            //FIXME: 暫定
            return "none"
        }
    }
    
    //検索ボタン押下時の処理
    func searchBarSearchButtonClicked(_ searchBar:UISearchBar) {
        
        //履歴表示を消す
        self.view.sendSubviewToBack(self.tableView!)
        
        // キーボードを閉じる
        self.view.endEditing(true)
        // 現在表示中のピンをすべて消す
        self.MapView.removeAnnotations(MapView.annotations)
        
        // 未入力の場合は終了
        guard let address = searchBar.text else {
            return
        }
        
        a = searchBar.text
        //検索ワードをローカルストレージへ登録
        let word = searchWord(word: address, timestamp: Date())
        history.append(searchWord: word)
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: history), forKey: "history")
        
        mapSearch(address: address)
        
        self.searchBar.text = ""
        history = loadHistory()
        tableView?.reloadData()
    }

        
        
    func mapSearch(address:String){
        //TODO:もし海外エリアとかを検索したい場合は考えないとなぁ...
        CLGeocoder().geocodeAddressString("札幌") { [weak MapView] placemarks, error in
            guard let loc = placemarks?.first?.location?.coordinate else {
                return
            }
            // 縮尺を設定
            let region = MKCoordinateRegion(center: loc,
                                            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            
            Map.search(query: address, region: region) { (result) in
                switch result {
                case .success(let mapItems):
                    for map in mapItems {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = map.placemark.coordinate
                        annotation.title = map.name ?? "名前がありません"
                        MapView?.addAnnotation(annotation)
                    }
                    
                    let point = MKCoordinateRegion(center: (mapItems.first?.placemark.coordinate)!,
                                                   span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                    MapView?.setRegion(point,animated:true)
                    self.searchedView.isHidden = false
                    
                    let name = mapItems.first?.placemark.name
                    let time = Date()
                    let latitude = mapItems.first?.placemark.coordinate.latitude
                    let longitude = mapItems.first?.placemark.coordinate.longitude
                    let genre = 0
                    
                    self.searchedPlace = VisitedPlace(n: name!, t: time, la: latitude!, lo: longitude!, g: genre)
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        self.view.sendSubviewToBack(self.tableView!)
        print("編集終了")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        self.searchBarTextDidEndEditing(_ : searchBar)
        self.view.sendSubviewToBack(self.searchedView!)
        print("キャンセルボタンがタップ")
    }
    
    //検索ワードの初期化
    func clearCache() {
        history.clear()
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: history),forKey: "history")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        // 現在地取得
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!
        print("lon : " + lonStr)
        print("lat : " + latStr)
        // 現在位置とタッウプした位置の距離(m)を算出する
        let distance = calcDistance(MapView.userLocation.coordinate, pointAno.coordinate)
        
        if (0 != distance) {
            // ピンに設定する文字列を生成する
            var str:String = Int(distance).description
            str = str + " m"
            
            if pointAno.title != str {
                // ピンまでの距離に変化があればtitleを更新する
                pointAno.title = str
                MapView.addAnnotation(pointAno)
            }
        }
    }
    
    //行きたい場所リスト追加ボタンタップ時の処理
    @IBAction func wannaGoPlaceButtonTapped(_ sender: Any) {
        wannaGoPlaces.append(searchedPlace!)
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: wannaGoPlaces), forKey: "wannaGoPlaces")
        navigationController?.setNavigationBarHidden(false, animated: true)
        performSegue(withIdentifier: "topToWantSegue", sender: self)
    }
    
    //確認ボタンタップ時の処理
    @IBAction func mapCheckButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "topToDetailsSegue",sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "topToDetailsSegue" {
                //遷移先ViewCntrollerの取得
                let nextView = segue.destination as! LocationDetailsViewController
                //値の設定
                //searchBarの値がここが呼ばれる前に初期化されてるので、何かで値をもらいたい！
                nextView.address = a!
            }
        }
    
    func initMap() {
        // 縮尺を設定
        var region:MKCoordinateRegion = MapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        MapView.setRegion(region,animated:true)
        
        // 現在位置表示の有効化
        MapView.showsUserLocation = true
        // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        MapView.userTrackingMode = .follow
    }
    
    // 2点間の距離(m)を算出する
    func calcDistance(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> CLLocationDistance {
        // CLLocationオブジェクトを生成
        let aLoc: CLLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let bLoc: CLLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
        // CLLocationオブジェクトのdistanceで2点間の距離(m)を算出
        let dist = bLoc.distance(from: aLoc)
        return dist
    }
    
    // UILongPressGestureRecognizerのdelegate：ロングタップを検出する
    @IBAction func mapViewDidLongPress(_ sender: UILongPressGestureRecognizer) {
        // ロングタップ開始
        if sender.state == .began {
        }
            // ロングタップ終了（手を離した）
        else if sender.state == .ended {
            // タップした位置（CGPoint）を指定してMkMapView上の緯度経度を取得する
            let tapPoint = sender.location(in: view)
            let center = MapView.convert(tapPoint, toCoordinateFrom: MapView)
            
            let lonStr = center.longitude.description
            let latStr = center.latitude.description
            print("lon : " + lonStr)
            print("lat : " + latStr)
            
            // 現在位置とタッウプした位置の距離(m)を算出する
            let distance = calcDistance(MapView.userLocation.coordinate, center)
            print("distance : " + distance.description)
            
            // ロングタップを検出した位置にピンを立てる
            pointAno.coordinate = center
            MapView.addAnnotation(pointAno)
            
        }
    }
    @objc func menuTaped(_ sender : UITapGestureRecognizer) {
        performSegue(withIdentifier: "topToMenuSegue", sender: self)
    }

    
    //ローカルストレージから読み込み。
    func loadHistory() -> History {
        if let loadedData = UserDefaults().data(forKey: "history") {
            let history = NSKeyedUnarchiver.unarchiveObject(with: loadedData) as! History
            return history
        } else {
            return History()
        }
    }
}
//マップローカル検索用の拡張クラス
extension MKPlacemark {
    var address: String {
        let components = [self.administrativeArea, self.locality, self.thoroughfare, self.subThoroughfare]
        return components.compactMap { $0 }.joined(separator: "")
    }
}

struct Map {
    enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    static func search(query: String, region: MKCoordinateRegion? = nil, completionHandler: @escaping (Result<[MKMapItem]>) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        if let region = region {
            request.region = region
        }
        
        MKLocalSearch(request: request).start { (response, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(response?.mapItems ?? []))
        }
    }
}
