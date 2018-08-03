//
//  SearchByNoteView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class SearchByNoteView: UIView {

    var selectedDetailNote = -1
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonNoMCs: UIButton!
    @IBOutlet weak var buttonPPs: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "Select Detail Note".localized
        buttonNoMCs.setTitle("No MAX COMBOs".localized, for: .normal)
        buttonPPs.setTitle("PERFECT PLAYs".localized, for: .normal)
        initializeButtons()
    }

    class func instanceFromXib() -> UIView{
        return UINib(nibName: "SearchByNoteView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
    @IBAction func clickButtons(_ sender: UIButton) {
        initializeButtons()
        buttonNoMCs.isSelected = false
        buttonPPs.isSelected = false
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.main
        }
        switch(sender.tag){
        case 0:
            selectedDetailNote = 0
        case 1:
            selectedDetailNote = 1
        default:
            break
        }
    }
    
    func initializeButtons(){
        UIView.animate(withDuration: 0.3) {
            self.buttonNoMCs.backgroundColor = UIColor.sub
            self.buttonPPs.backgroundColor = UIColor.sub
        }
        buttonNoMCs.layer.borderColor = UIColor.main.cgColor
        buttonPPs.layer.borderColor = UIColor.main.cgColor
        buttonNoMCs.layer.borderWidth = 2
        buttonPPs.layer.borderWidth = 2
    }
}
