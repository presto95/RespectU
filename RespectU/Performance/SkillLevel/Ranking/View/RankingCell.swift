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
    
    func setProperties(_ dictionary: [(key: String, value: Double)], at row: Int, isPerfect: Bool) {
        self.rankingLabel.text = "\(row + 1)"
        self.nicknameLabel.text = dictionary[row].key
        self.valueLabel.text = isPerfect ? "\(Int(dictionary[row].value))" : "\(dictionary[row].value)"
    }
    
    func setProperties(_ dictionary: [(key: String, value: Int)], at row: Int) {
        self.rankingLabel.text = "\(row + 1)"
        self.nicknameLabel.text = dictionary[row].key
        self.valueLabel.text = "\(dictionary[row].value)"
    }
}
