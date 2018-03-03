//
//  SongCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 3..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var bpm: UILabel!
    @IBOutlet weak var nm: UILabel!
    @IBOutlet weak var hd: UILabel!
    @IBOutlet weak var mx: UILabel!
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
