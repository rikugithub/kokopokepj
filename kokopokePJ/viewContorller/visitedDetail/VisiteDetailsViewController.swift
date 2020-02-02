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
    
    @IBOutlet weak var seeReviewButton: UIButton!
    @IBOutlet weak var PostOrSaveButton: UIButton!
    @IBOutlet weak var visitedgenre: UILabel!
    @IBOutlet weak var visitedMapView: MKMapView!
    @IBOutlet weak var visitedPlaceName: UILabel!
    @IBOutlet weak var congestionLabel: UILabel!
    
    public var visitedPlace:VisitedPlace!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: visitedPlace.getLatitude(),longitude: visitedPlace.getLongitude())
        self.visitedMapView.setCenter(location, animated: true)
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: location, span: mySpan)

        visitedMapView.region = myRegion
        
        visitedPlaceName.text = visitedPlace.getName()
        //FIXME: 変換
        visitedgenre.text = visitedPlace.getGenre().description
    }
    
    @IBAction func seeReviewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToReviewSegue", sender: self)
    }
    
    @IBAction func PostOrSaveButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "detailToPostSegue", sender: self)
    }
    
    //segue遷移直前に実行される処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToReviewSegue" {
            let nextVC = segue.destination as! ReviewListViewConroller
            nextVC.areaName = visitedPlace.getName()
        }
    }
}
