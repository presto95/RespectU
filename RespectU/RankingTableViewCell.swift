//
//  RankingTableViewCell.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 20..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {

    @IBOutlet weak var ranking: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var point: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
