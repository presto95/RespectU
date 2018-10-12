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
        colorLabel.layer.cornerRadius = colorLabel.bounds.width / 2
        colorLabel.layer.masksToBounds = true
    }
    
    func setProperties(_ object: SongInfo?) {
        guard let object = object else { return }
        let gradient = object.series.seriesGradientVertical ?? CAGradientLayer()
        gradient.frame = colorLabel.bounds
        colorLabel.layer.addSublayer(gradient)
        titleLabel.text = object.localizedTitle
    }
}
