//
//  SearchRecordDetailCell.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import RealmSwift

class SearchRecordDetailCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nm: UILabel!
    @IBOutlet weak var hd: UILabel!
    @IBOutlet weak var mx: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var labelNm: UILabel!
    @IBOutlet weak var labelHd: UILabel!
    @IBOutlet weak var labelMx: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        color.layer.borderWidth = 1
        color.layer.borderColor = UIColor.mainColor.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
