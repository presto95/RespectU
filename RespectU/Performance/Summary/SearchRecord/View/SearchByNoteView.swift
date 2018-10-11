//
//  SearchByNoteView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 19..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

protocol SearchByNoteViewDelegate: class {
    func touchUpNoteButtons(_ sender: UIButton)
}

class SearchByNoteView: UIView {

    weak var delegate: SearchByNoteViewDelegate?
    @IBOutlet weak var noMaxComboButton: UIButton!
    @IBOutlet weak var perfectPlayButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noMaxComboButton.setTitle("No MAX COMBOs".localized, for: .normal)
        perfectPlayButton.setTitle("PERFECT PLAYs".localized, for: .normal)
        initializeButtons()
    }
    
    @IBAction func touchUpButtons(_ sender: UIButton) {
        delegate?.touchUpNoteButtons(sender)
        initializeButtons()
        noMaxComboButton.isSelected = false
        perfectPlayButton.isSelected = false
        sender.isSelected = true
        UIView.animate(withDuration: 0.3) {
            sender.backgroundColor = .main
        }
    }
    
    private func initializeButtons() {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.noMaxComboButton.backgroundColor = .sub
            self.perfectPlayButton.backgroundColor = .sub
        }
        noMaxComboButton.layer.borderColor = UIColor.main.cgColor
        perfectPlayButton.layer.borderColor = UIColor.main.cgColor
        noMaxComboButton.layer.borderWidth = 2
        perfectPlayButton.layer.borderWidth = 2
    }
}
