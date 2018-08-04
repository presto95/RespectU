//
//  SearchByLevelView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 24..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import AKPickerView_Swift

class SearchByLevelView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: AKPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.pickerViewStyle = .wheel
        pickerView.selectItem(0)
        pickerView.layer.borderWidth = 2
        pickerView.layer.borderColor = UIColor.main.cgColor
        pickerView.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        pickerView.highlightedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        pickerView.viewDepth = UIScreen.main.bounds.width
        pickerView.reloadData()
        label.text = "Select Level".localized
    }
}
