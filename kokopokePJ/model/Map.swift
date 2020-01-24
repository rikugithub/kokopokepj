//
//  Map.swift
//  kokopokePJ
//
//  Created by 二川純哉 on 2020/01/24.
//  Copyright © 2020 Saki Nakayama. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapLocation{

    @IBOutlet weak var mapView: MKMapView!
    
    //位置情報コントローラー
    var  locManager: CLLocationManager!
    //ピン
    var pointAno: MKPointAnnotation = MKPointAnnotation()
    
    
    required init() {
        // 地図の初期化
        initMap()
        
        locManager = CLLocationManager()
        locManager.delegate = self as? CLLocationManagerDelegate
        
        // 座標の表示
        locManager.startUpdatingLocation()
    }
    
    func updateCurrentPos(_ coordinate:CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region,animated:true)
    }
    
    func initMap() {
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
    }
}


