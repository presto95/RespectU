//
//  SongTableViewCell.swift
//  RespectU
//
//  Created by Presto on 2017. 9. 29..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var composer: UILabel!
    @IBOutlet weak var bpm: UILabel!
    @IBOutlet weak var nm: UILabel!
    @IBOutlet weak var hd: UILabel!
    @IBOutlet weak var mx: UILabel!
    @IBOutlet weak var nmNote: UILabel!
    @IBOutlet weak var hdNote: UILabel!
    @IBOutlet weak var mxNote: UILabel!
    @IBOutlet weak var series: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
