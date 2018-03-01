//
//  TrophyTableViewCell.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 4..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class TrophyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trophyImage: UIImageView!
    @IBOutlet weak var titleKor: UILabel!
    @IBOutlet weak var contentKor: UILabel!
    @IBOutlet weak var ratingColor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
