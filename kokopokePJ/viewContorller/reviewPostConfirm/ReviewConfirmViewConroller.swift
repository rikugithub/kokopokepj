//
//  ReviewConfirmViewConroller.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit
import Firebase

class ReviewConfirmViewConroller: UITableViewController {
    
    @IBOutlet weak var postHostLabel: UILabel!
    @IBOutlet weak var visitedDay: UILabel!
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var withHuman: UILabel!
    @IBOutlet weak var imageViewTwo: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    
    var ref = Database.database().reference();
    
    var postHostText:String?
    var visitedDayText:String?
    var evaluationText:String?
    var genreText:String?
    var withHumanText:String?
    var imageViewImg:UIImage?
    var reviewText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postHostLabel.text = postHostText
        visitedDay.text = visitedDayText
        evaluationLabel.text = evaluationText
        genreLabel.text = genreText
        withHuman.text = withHumanText
        imageViewTwo.image = imageViewImg
        reviewLabel.text = reviewText
        
    }
    
    @IBAction func postTouch(_ sender: Any) {
        func addDB(vPN:String,pUN:String,pUA:String,pUG:Bool,vT:String,pT:String,vPG:Int,wW:Int,wWE:String,iURL:String,rC:String,memo:String) {
            let review = Review(vPN: vPN, pUN: pUN, pUA: pUA, pUG: pUG, vT: vT, pT: pT,rt: 1, vPG: vPG, wW: wW, wWE: wWE, iURL: iURL, rC: rC, memo: memo)
            let newRf = ref.child("reviews").child(vPN).childByAutoId()
            newRf.setValue(review.toDictionary())
        }
    }
}

