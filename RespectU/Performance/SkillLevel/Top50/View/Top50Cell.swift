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
        switch button {
        case Buttons.button4:
            self.difficultyLabel.text = object.button4.highestSkillPointDifficulty
            self.noteLabel.text = object.button4.highestSkillPointNote
            self.rateLabel.text = "\(object.button4.highestSkillPointRate)%"
            self.skillPointLabel.text = "\(object.button4.highestSkillPoint)"
        case Buttons.button5:
            self.difficultyLabel.text = object.button5.highestSkillPointDifficulty
            self.noteLabel.text = object.button5.highestSkillPointNote
            self.rateLabel.text = "\(object.button5.highestSkillPointRate)%"
            self.skillPointLabel.text = "\(object.button5.highestSkillPoint)"
        case Buttons.button6:
            self.difficultyLabel.text = object.button6.highestSkillPointDifficulty
            self.noteLabel.text = object.button6.highestSkillPointNote
            self.rateLabel.text = "\(object.button6.highestSkillPointRate)%"
            self.skillPointLabel.text = "\(object.button6.highestSkillPoint)"
        case Buttons.button8:
            self.difficultyLabel.text = object.button8.highestSkillPointDifficulty
            self.noteLabel.text = object.button8.highestSkillPointNote
            self.rateLabel.text = "\(object.button8.highestSkillPointRate)%"
            self.skillPointLabel.text = "\(object.button8.highestSkillPoint)"
        default:
            break
        }
    }
}
