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
        self.colorLabel.layer.borderWidth = 1
        self.colorLabel.layer.borderColor = UIColor.main.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: RecordInfo) {
        self.titleLabel.text = object.title
        self.colorLabel.backgroundColor = object.series.seriesColor
    }
}
