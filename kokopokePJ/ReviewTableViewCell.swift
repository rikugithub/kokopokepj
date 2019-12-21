//
//  ReviewTableViewCell.swift
//  kokopokePJ
//
//  Created by しゅん on 2019/12/21.
//  Copyright © 2019 Saki Nakayama. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postUserName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
