//
//  GuideReusableView.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import UIKit

class GuideReusableView: UICollectionReusableView {
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    func setProperties(_ title: String) {
        sectionTitle.text = title
    }
}
