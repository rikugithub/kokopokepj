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

class TopViewController: UIViewController,UISearchBarDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var MapView: MKMapView!
    @IBOutlet var LongPressGesRec: UILongPressGestureRecognizer!
    @IBOutlet weak var menuButton: UIImageView!
    @IBOutlet weak var searchedView: UIView!
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var searchView: UIView!
    
    public let userDefaults = UserDefaults.standard
    var locManager: CLLocationManager!
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    var tableView: UITableView?
    //履歴テストデータ
    let history = ["test","test2","test3"]
    let sectionTitle = ["今日","昨日","今週","先週"]
    var searchedPlace:VisitedPlace?
    var wannaGoPlaces:[VisitedPlace] = []

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
        
        userDefaults.register(defaults: ["wannaGoPlaces": [wannaGoPlaces]])
        
        //serchBar入力状態でマップをシングルタップして入力解除するための処理
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        singleTapGesture.numberOfTapsRequired = 1
        
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
                 self.view.addSubview(tableView)
                 return tableView
             }()
        self.view.sendSubviewToBack(self.tableView!)
        self.view.addGestureRecognizer(singleTapGesture)
        
        //検索時メニューバーの設定
        let height = self.view.bounds.height/4
        let width = self.view.bounds.width
        searchedView.frame = CGRect(x: 0, y: self.view.bounds.height - height, width: width, height: height)
        searchedView.backgroundColor = UIColor.white
        self.searchedView.isHidden = true
    }
    
    //シングルタップによる入力解除の処理
    @objc func singleTap(_ gesture: UITapGestureRecognizer) {
         searchBar.endEditing(true)
        self.searchBarTextDidEndEditing(_ : searchBar)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
             return 4
           }
    
    //1セクションごとに表示する行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return 3
    }
    
    //セルの中身設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
      ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")

      cell.textLabel?.text = self.history[indexPath.row]

      return cell
    }
    
    //セクションタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
        
     
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //TODO:履歴を検索する
        searchBar.showsCancelButton = true
        self.view.bringSubviewToFront(self.tableView!)

        print("入力ボタンがタップ")
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar:UISearchBar) {
        
        self.view.sendSubviewToBack(self.tableView!)
        // キーボードを閉じる
        self.view.endEditing(true)
        // 現在表示中のピンをすべて消す
        self.MapView.removeAnnotations(MapView.annotations)

        // 未入力の場合は終了
        guard let address = searchBar.text else {
            return
        }

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
        //検索バーを空欄にする
        self.searchBar.text = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        self.view.sendSubviewToBack(self.tableView!)
        print("編集終了")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.endEditing(true)
        self.searchBarTextDidEndEditing(_ : searchBar)
        print("キャンセルボタンがタップ")
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
    
    @IBAction func wannaGoPlaceButtonTapped(_ sender: Any) {
        wannaGoPlaces.append(searchedPlace!)
        userDefaults.set(NSKeyedArchiver.archivedData(withRootObject: wannaGoPlaces), forKey: "wannaGoPlaces")
        navigationController?.setNavigationBarHidden(false, animated: true)
        performSegue(withIdentifier: "topToWantSegue", sender: self)
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
    
    func getTimeNow() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let now = Date()
        return f.string(from: now)
    }
}
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
