//
//  SummaryCollectionCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 5..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SummaryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    let contents = [Rank.s, Rank.a, Rank.b, Rank.c, Note.maxCombo, Note.perfectPlay, "\(Note.maxCombo)+\(Note.perfectPlay)"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.main.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 10
    }
    
    func setProperties(_ results: Results<NewRecordInfo>, at item: Int) {
        let buttons = ["button4", "button5", "button6", "button8"]
        let difficulties = ["normal", "hard", "maximum"]
        var count: Int = 0
        self.contentLabel.text = self.contents[item]
        switch item {
        case 0, 1, 2, 3:
            self.valueLabel.text = {
                for result in results {
                    for button in buttons {
                        guard let buttonResult = result.value(forKey: button) as? NewRecordButtonInfo else { return nil }
                        for difficulty in difficulties {
                            guard let difficultyResult = buttonResult.value(forKey: difficulty) as? NewRecordDifficultyInfo else { return nil }
                            if difficultyResult.rank == self.contents[item] {
                                count += 1
                            }
                        }
                    }
                }
                return "\(count)"
            }()
        case 4, 5:
            self.valueLabel.text = {
                for result in results {
                    for button in buttons {
                        guard let buttonResult = result.value(forKey: button) as? NewRecordButtonInfo else { return nil }
                        for difficulty in difficulties {
                            guard let difficultyResult = buttonResult.value(forKey: difficulty) as? NewRecordDifficultyInfo else { return nil }
                            if difficultyResult.note == self.contents[item] {
                                count += 1
                            }
                        }
                    }
                }
                return "\(count)"
            }()
        case 6:
            self.valueLabel.text = {
                for result in results {
                    for button in buttons {
                        guard let buttonResult = result.value(forKey: button) as? NewRecordButtonInfo else { return nil }
                        for difficulty in difficulties {
                            guard let difficultyResult = buttonResult.value(forKey: difficulty) as? NewRecordDifficultyInfo else { return nil }
                            if difficultyResult.note == self.contents[4] || difficultyResult.note == self.contents[5] {
                                count += 1
                            }
                        }
                    }
                }
                return "\(count)"
            }()
        default:
            break
        }
    }
}
