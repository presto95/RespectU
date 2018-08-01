//
//  TrophyCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class TrophyCell: UITableViewCell {

    
    @IBOutlet weak var imageTrophy: UIImageView!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        color.layer.borderColor = UIColor.mainColor.cgColor
        color.layer.borderWidth = 1
        imageTrophy.layer.borderWidth = 1
        imageTrophy.layer.borderColor = UIColor.mainColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
