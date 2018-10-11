//
//  CommonButton.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

class CommonButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.main.cgColor
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        setTitleColor(.main, for: [])
    }
}
