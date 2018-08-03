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
        self.titleLabel.text = object.title
        switch button {
        case Buttons.button4:
            self.difficultyLabel.text = object.button4HighestSkillPointDifficulty
            self.noteLabel.text = object.button4HighestSkillPointNote
            self.rateLabel.text = object.button4HighestSkillPointRate
            self.skillPointLabel.text = "\(object.button4SkillPoint)"
        case Buttons.button5:
            self.difficultyLabel.text = object.button5HighestSkillPointDifficulty
            self.noteLabel.text = object.button5HighestSkillPointNote
            self.rateLabel.text = object.button5HighestSkillPointRate
            self.skillPointLabel.text = "\(object.button5SkillPoint)"
        case Buttons.button6:
            self.difficultyLabel.text = object.button6HighestSkillPointDifficulty
            self.noteLabel.text = object.button6HighestSkillPointNote
            self.rateLabel.text = object.button6HighestSkillPointRate
            self.skillPointLabel.text = "\(object.button6SkillPoint)"
        case Buttons.button8:
            self.difficultyLabel.text = object.button8HighestSkillPointDifficulty
            self.noteLabel.text = object.button8HighestSkillPointNote
            self.rateLabel.text = object.button8HighestSkillPointRate
            self.skillPointLabel.text = "\(object.button8SkillPoint)"
        default:
            break
        }
    }
}
