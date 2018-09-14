//
//  RankingCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 4..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {

    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProperties(_ object: [RankingResponse.Ranking], at row: Int, button: String) {
        self.rankingLabel.text = "\(row + 1)"
        self.nicknameLabel.text = object[row].nickname
        switch button {
        case Buttons.button4:
            self.valueLabel.text = "\(object[row].button4)"
        case Buttons.button5:
            self.valueLabel.text = "\(object[row].button5)"
        case Buttons.button6:
            self.valueLabel.text = "\(object[row].button6)"
        case Buttons.button8:
            self.valueLabel.text = "\(object[row].button8)"
        default:
            break
        }
    }
}
