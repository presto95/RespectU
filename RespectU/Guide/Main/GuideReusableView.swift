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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setProperties(_ title: String) {
        self.sectionTitle.text = title
    }
}
