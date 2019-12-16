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

class TopViewController: UIViewController,
CLLocationManagerDelegate,
UIGestureRecognizerDelegate {

    @IBOutlet var MapView: MKMapView!
    var locManager: CLLocationManager!

    @IBOutlet var LongPressGesRec: UILongPressGestureRecognizer!
    
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    @IBOutlet weak var menuButton: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        menuButton.isUserInteractionEnabled = true
        //menuButtonがタップされたら呼ばれる
        menuButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.menuTaped(_:))))
        
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
}
