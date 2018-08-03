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
        settings.style.buttonBarBackgroundColor = .sub
        settings.style.buttonBarItemBackgroundColor = .sub
        settings.style.selectedBarBackgroundColor = .main
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}
