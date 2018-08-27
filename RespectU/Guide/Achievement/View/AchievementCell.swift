//
//  AchievementCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class AchievementCell: UITableViewCell {

    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: AchievementResponse.Achievement?, isAll: Bool = false) {
        self.stageLabel.text = "\(object?.level ?? 0)"
        self.itemLabel.text = object?.localizedItem
        self.typeLabel.text = isAll ? object?.type.uppercased() : nil
    }
}
