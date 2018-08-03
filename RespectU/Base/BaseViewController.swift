//
//  SongBaseViewController.swift
//  RespectU
//
//  Created by Presto on 2018. 8. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BaseViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonBarPagerTabStrip()
    }
    
    private func setUpButtonBarPagerTabStrip() {
        settings.style.buttonBarBackgroundColor = .subColor
        settings.style.buttonBarItemBackgroundColor = .subColor
        settings.style.selectedBarBackgroundColor = .mainColor
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}
