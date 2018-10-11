//
//  RecordCell.swift
//  RespectU
//
//  Created by Presto on 2018. 4. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    lazy var labels: [UILabel] = {
        return [colorLabel, titleLabel]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.borderWidth = 1
        colorLabel.layer.borderColor = UIColor.main.cgColor
    }
    
    func setProperties(_ object: SongInfo?) {
        guard let object = object else { return }
        colorLabel.backgroundColor = object.series.seriesColor
        titleLabel.text = object.localizedTitle
    }
}
