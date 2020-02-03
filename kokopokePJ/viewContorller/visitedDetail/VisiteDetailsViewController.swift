//
//  visiteDetailsViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/12.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//訪れた場所の詳しい情報
class VisiteDetailsViewController: UIViewController{
    
    @IBOutlet weak var visitedMapView: MKMapView!
    @IBOutlet weak var visitedPlaceName: UILabel!
    
    public var visitedPlace:VisitedPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: visitedPlace.getLatitude(),longitude: visitedPlace.getLongitude())
        self.visitedMapView.setCenter(location, animated: true)
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: location, span: mySpan)

        visitedMapView.region = myRegion
        
        visitedPlaceName.text = visitedPlace.getName()
    }
    
    @IBAction func seeReviewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToReviewSegue", sender: self)
    }
    
    @IBAction func PostOrSaveButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToPostSegue", sender: self)
    }
    
    @IBAction func startNavigationButtonTapped(_ sender: Any) {
        // 2つ前のViewControllerに戻る
        let index = navigationController!.viewControllers.count - 4
        let controller = navigationController!.viewControllers[index] as? TopViewController
        //self.navigationController?.popToRootViewController(animated: true)
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
        controller?.startNavigation(targetLat: self.visitedPlace.getLatitude(), targetLon: self.visitedPlace.getLongitude())
    }
    //segue遷移直前に実行される処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToReviewSegue" {
            let nextVC = segue.destination as! ReviewListViewConroller
            nextVC.areaName = visitedPlace.getName()
        } else if segue.identifier == "detailToPostSegue" {
            let nextVC = segue.destination as! ReviewPostFormViewController
            nextVC.placeName = visitedPlace.getName()
        }
    }
}
