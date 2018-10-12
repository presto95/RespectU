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
    
    func setProperties(_ object: [RankingResponse.Ranking], at row: Int, button: String) {
        rankingLabel.text = "\(row + 1)"
        nicknameLabel.text = object[row].nickname
        switch button {
        case Buttons.button4:
            valueLabel.text = String(format: "%4.2f", object[row].button4)
        case Buttons.button5:
            valueLabel.text = String(format: "%4.2f", object[row].button5)
        case Buttons.button6:
            valueLabel.text = String(format: "%4.2f", object[row].button6)
        case Buttons.button8:
            valueLabel.text = String(format: "%4.2f", object[row].button8)
        default:
            break
        }
    }
}
