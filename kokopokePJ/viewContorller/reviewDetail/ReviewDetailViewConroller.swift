//
//  ReviewDetailViewConroller.swift
//  kokopokePJ
//
//  Created by さっちゃん on 2019/12/16.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewDetailViewConroller: UIViewController {
    
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var visitedTimestamp: UILabel!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var reviewContent: UITextView!
    @IBOutlet weak var reviewPostImage: UIImageView!
    
    public var review:Review!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingValueLabel.text = review.getRating()
        visitedTimestamp.text = review.getPostTimestamp()
        postNameLabel.text = review.getPostUserName()
        reviewContent.text = review.getReviewContent()
        if let image = loadImage(url: review.getImgURL()) {
            reviewPostImage.image = image
        }
    }
    
    func loadImage(url:String) -> UIImage? {
        //くるくる開始
        startIndicator()
        guard let url = URL(string: url) else {
            return nil
        }
        let data:Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            return nil
        }
        return UIImage(data: data)
    }
}
