//
//  Top50TableViewCell.swift
//  RespectU
//
//  Created by Presto on 2018. 1. 12..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class Top50TableViewCell: UITableViewCell {

    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var skillPoint: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var rate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
