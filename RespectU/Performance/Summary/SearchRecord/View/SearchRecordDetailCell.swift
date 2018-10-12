//
//  SearchRecordDetailCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SearchRecordDetailCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
        colorLabel.layer.masksToBounds = true
    }
    
    func setProperties(_ object: SearchRecordDetail) {
        colorLabel.backgroundColor = object.series.seriesColor
        titleLabel.text = object.title
        difficultyLabel.text = object.difficulty.uppercased()
        rateLabel.text = "\(object.rate)%"
    }
}
