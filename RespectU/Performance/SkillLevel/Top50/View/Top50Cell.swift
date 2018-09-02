//
//  Top50Cell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class Top50Cell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var skillPointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colorLabel.layer.borderColor = UIColor.main.cgColor
        self.colorLabel.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: RecordInfo, button: String) {
        self.colorLabel.backgroundColor = object.series.seriesColor
        self.titleLabel.text = object.localizedTitle
        guard let button = object.value(forKeyPath: button) as? RecordButtonInfo else { return }
        self.difficultyLabel.text = button.highestSkillPointDifficulty
        self.noteLabel.text = button.highestSkillPointNote.noteExpansion
        self.rateLabel.text = "\(button.highestSkillPointRate)%"
    }
}
