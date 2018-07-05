//
//  SearchByRateView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SearchByRateView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var lowerRate: UITextField!
    @IBOutlet weak var upperRate: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "Rate Range (%)".localized
        lowerRate.placeholder = "More Than".localized
        upperRate.placeholder = "Below".localized
        lowerRate.layer.borderColor = UIColor.mainColor.cgColor
        upperRate.layer.borderColor = UIColor.mainColor.cgColor
        lowerRate.layer.borderWidth = 2
        upperRate.layer.borderWidth = 2
        lowerRate.keyboardType = .decimalPad
        upperRate.keyboardType = .decimalPad
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.mainColor
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickDone))
        toolBar.setItems([space, done], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        lowerRate.inputAccessoryView = toolBar
        upperRate.inputAccessoryView = toolBar
    }
    
    class func instanceFromXib() -> UIView{
        return UINib(nibName: "SearchByRateView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
    @objc func clickDone(){
        if(lowerRate.isFirstResponder){
            lowerRate.resignFirstResponder()
            guard let text = lowerRate.text else { return }
            guard let value = Double(text) else { return }
            if(value >= 100){
                lowerRate.text = "100"
            }
        } else if(upperRate.isFirstResponder){
            upperRate.resignFirstResponder()
            guard let text = upperRate.text else { return }
            guard let value = Double(text) else { return }
            if(value >= 100){
                upperRate.text = "100"
            }
        }
    }
}
