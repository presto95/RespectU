//
//  SearchByNoteView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

protocol SearchByNoteViewDelegate {
    func touchUpNoteButtons(_ sender: UIButton)
}

class SearchByNoteView: UIView {

    var delegate: SearchByNoteViewDelegate?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var noMaxComboButton: UIButton!
    @IBOutlet weak var perfectPlayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "Select Detail Note".localized
        noMaxComboButton.setTitle("No MAX COMBOs".localized, for: .normal)
        perfectPlayButton.setTitle("PERFECT PLAYs".localized, for: .normal)
        initializeButtons()
    }
    
    @IBAction func touchUpButtons(_ sender: UIButton) {
        delegate?.touchUpNoteButtons(sender)
        initializeButtons()
        noMaxComboButton.isSelected = false
        perfectPlayButton.isSelected = false
        sender.isEnabled = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = UIColor.main
        }
    }
    
    private func initializeButtons() {
        UIView.animate(withDuration: 0.3) {
            self.noMaxComboButton.backgroundColor = UIColor.sub
            self.perfectPlayButton.backgroundColor = UIColor.sub
        }
        noMaxComboButton.layer.borderColor = UIColor.main.cgColor
        perfectPlayButton.layer.borderColor = UIColor.main.cgColor
        noMaxComboButton.layer.borderWidth = 2
        perfectPlayButton.layer.borderWidth = 2
    }
}
