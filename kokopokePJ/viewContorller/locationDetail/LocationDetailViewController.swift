//
//  LocationInforViewController.swift
//  kokopokePJ
//
//  Created by Saki Nakayama on 2019/12/17.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailsViewController: UIViewController {

    @IBOutlet weak var wannaGoMapView: MKMapView!
    @IBOutlet weak var selectPlace: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationDetail = LocationDetail()
        let word :String = locationDetail.getWord()
        let searchLatitude:Int = locationDetail.getLatitude()
        let searchLongitude:Int = locationDetail.getLongitude()
        
        selectPlace.text = word
        let location =
            CLLocationCoordinate2D(latitude: CLLocationDegrees(searchLatitude),longitude: CLLocationDegrees(searchLongitude))
        self.wannaGoMapView.setCenter(location, animated: true)
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let _: MKCoordinateRegion = MKCoordinateRegion(center: location, span: mySpan)
}
    
    @IBAction func checkReviewListButtonTapped(_ sender: Any) {
    performSegue(withIdentifier: "locationDetailToReviewListSegue", sender: self)
    }
    
    @IBAction func postReviewButtonTapped(_ sender: Any) {
                performSegue(withIdentifier: "LocationDetailToReviewPostSegue", sender: self)
    }
    
    
}
