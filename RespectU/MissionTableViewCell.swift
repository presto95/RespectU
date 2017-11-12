//
//  MissionTableViewCell.swift
//  RespectU
//
//  Created by Presto on 2017. 9. 30..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class MissionTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var color: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
