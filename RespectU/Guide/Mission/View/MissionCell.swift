//
//  MissionCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class MissionCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    lazy var labels: [UILabel] = {
        return [titleLabel, rewardLabel]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.borderColor = UIColor.main.cgColor
        colorLabel.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: MissionInfo) {
        self.colorLabel.backgroundColor = object.section.missionColor
        self.titleLabel.text = object.title
        self.rewardLabel.text = object.reward.isEmpty ? "None".localized : object.reward
    }
}
