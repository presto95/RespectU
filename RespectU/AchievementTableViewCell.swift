//
//  AchievementTableViewCell.swift
//  RespectU
//
//  Created by Presto on 2017. 11. 10..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {

    @IBOutlet weak var stage: UILabel!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
