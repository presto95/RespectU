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
        setUpButtonBarPagerTabStrip()
        super.viewDidLoad()
    }
    
    private func setUpButtonBarPagerTabStrip() {
        settings.style.selectedBarHeight = 1
        settings.style.selectedBarBackgroundColor = .black
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
}
