//
//  TrophyCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class TrophyCell: UITableViewCell {

    
    @IBOutlet weak var trophyImageView: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.layer.borderColor = UIColor.mainColor.cgColor
        colorLabel.layer.borderWidth = 1
        trophyImageView.layer.borderWidth = 1
        trophyImageView.layer.borderColor = UIColor.mainColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: TrophyInfo) {
        switch Locale.preferredLanguages[0] {
        case "ko-KR":
            self.titleLabel.text = object.titleKor
            self.contentLabel.text = object.contentKor
        default:
            self.titleLabel.text = object.titleEng
            self.contentLabel.text = object.contentEng
        }
        switch object.rating {
        case TrophyGrade.platinum:
            self.colorLabel.backgroundColor = .platinum
        case TrophyGrade.gold:
            self.colorLabel.backgroundColor = .gold
        case TrophyGrade.silver:
            self.colorLabel.backgroundColor = .silver
        case TrophyGrade.bronze:
            self.colorLabel.backgroundColor = .bronze
        default:
            break
        }
    }
}
