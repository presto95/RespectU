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
    var selectedLevel = 0
    let levels = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.pickerViewStyle = .wheel
        pickerView.selectItem(0)
        pickerView.layer.borderWidth = 2
        pickerView.layer.borderColor = UIColor.mainColor.cgColor
        pickerView.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        pickerView.highlightedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        pickerView.viewDepth = UIScreen.main.bounds.width
        pickerView.reloadData()
        label.text = "Select Level".localized
    }
    
    class func instanceFromXib() -> UIView{
        return UINib(nibName: "SearchByLevelView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
}

extension SearchByLevelView: AKPickerViewDataSource{
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return 15
    }
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return "\(levels[item])"
    }
}
extension SearchByLevelView: AKPickerViewDelegate{
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        selectedLevel = levels[item]
    }
}
