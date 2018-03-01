//
//  PlaylistTableViewCell.swift
//  RespectU
//
//  Created by Presto on 2017. 10. 16..
//  Copyright © 2017년 Presto. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var series: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var composer: UILabel!
    @IBOutlet weak var bpm: UILabel!
    @IBOutlet weak var normal: UILabel!
    @IBOutlet weak var hard: UILabel!
    @IBOutlet weak var maximum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
