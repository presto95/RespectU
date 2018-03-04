//
//  Top50Cell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class Top50Cell: UITableViewCell {

    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var skillPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        color.layer.borderColor = UIColor.mainColor.cgColor
        color.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
