//
//  WantToGoDetailViewController.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/22.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class WantToGoDetailViewController: UIViewController {
    var ref:DatabaseReference!
    public var area:VisitedPlace!
    @IBOutlet weak var wannaGoPlanceName: UILabel!
    @IBOutlet weak var wannaGoMapView: MKMapView!
    
    @IBOutlet weak var ratingLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: area.getLatitude(),longitude: area.getLongitude())
        self.wannaGoMapView.setCenter(location, animated: true)
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: location, span: mySpan)

        wannaGoMapView.region = myRegion
        wannaGoPlanceName.text = area.getName()
        loadRating(palceName: area.getName(), comp: { result in
            self.ratingLabel.text = self.convertRating(i: result)
        })
    }
    
    func loadRating(palceName:String,comp:@escaping(Int) -> Void) {
        ref = Database.database().reference().child("reviews").child(palceName)
        ref.observe(.value, with: { snapshot in
            var result:Int = 0
            if let values = snapshot.value as? [String:[String:Any]] {
                var rating:Int = 0
                for value in values {
                    let val = value.value
                    let review = Review(dic: val)
                    rating = rating + review.getRating()
                }
                result = rating / values.count
            }
            comp(result)
        })
    }
    
    @IBAction func checkReviewListButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "wantDetailToReviewSegue", sender: self)
    }
    
    @IBAction func startNaviButtonTapped(_ sender: Any) {
        // 2つ前のViewControllerに戻る
        let index = navigationController!.viewControllers.count - 4
        let controller = navigationController!.viewControllers[index] as? TopViewController
        //self.navigationController?.popToRootViewController(animated: true)
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
        controller?.startNavigation(targetLat: self.area.getLatitude(), targetLon: self.area.getLongitude())
    }
    
    @IBAction func postReviewButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "wannaGoDetailToPostSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wantDetailToReviewSegue" {
            let nextVC = segue.destination as! ReviewListViewConroller
            nextVC.areaName = area.getName()
        } else if segue.identifier == "wannaGoDetailToPostSegue" {
            let nextVC = segue.destination as! ReviewPostFormViewController
            nextVC.placeName = area.getName()
        }
    }
    
    //数値を評価に変換
    private func convertRating(i:Int) -> String {
        switch i {
        case 0:
            return "☆☆☆☆☆"
        case 1:
            return "★☆☆☆☆"
        case 2:
            return "★★☆☆☆"
        case 3:
            return "★★★☆☆"
        case 4:
            return "★★★★☆"
        case 5:
            return "★★★★★"
        default:
            //ここに来ることはない
            return "評価なし"
        }
    }

}
