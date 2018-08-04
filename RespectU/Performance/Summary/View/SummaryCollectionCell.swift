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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.main.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
    }
    
    func setProperties(_ results: Results<RecordInfo>, at item: Int) {
        let difficulties = ["nm", "hd", "mx"]
        let buttons = [4, 5, 6, 8]
        var count = 0
        let rankOrNote: String = {
            switch item {
            case 0:
                return Rank.s
            case 1:
                return Rank.a
            case 2:
                return Rank.b
            case 3:
                return Rank.c
            case 4:
                return Note.maxCombo
            case 5:
                return Note.perfectPlay
            default:
                return ""
            }
        }()
        switch item {
        case 0, 1, 2, 3:
            self.contentLabel.text = rankOrNote
            self.valueLabel.text = {
                for result in results {
                    for difficulty in difficulties {
                        for button in buttons {
                            let key = "\(difficulty)\(button)Rank"
                            let value = result.value(forKey: key) as? String ?? Rank.none
                            if value == rankOrNote {
                                count += 1
                            }
                        }
                    }
                }
                return "\(count)"
            }()
        case 4, 5:
            self.contentLabel.text = rankOrNote.noteAbbreviation
            self.valueLabel.text = {
                for result in results {
                    for difficulty in difficulties {
                        for button in buttons {
                            let key = "\(difficulty)\(button)Note"
                            let value = result.value(forKey: key) as? String ?? Note.none
                            if value == rankOrNote {
                                count += 1
                            }
                        }
                    }
                }
                return "\(count)"
            }()
        case 6:
            self.contentLabel.text = "\(Note.maxCombo.noteAbbreviation ?? "")+\(Note.perfectPlay.noteAbbreviation ?? "")"
            self.valueLabel.text = {
                for result in results {
                    for difficulty in difficulties {
                        for button in buttons {
                            let key = "\(difficulty)\(button)Note"
                            let value = result.value(forKey: key) as? String ?? Note.none
                            if value == Note.maxCombo || value == Note.perfectPlay {
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
