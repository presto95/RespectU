//
//  Banner+.swift
//  RespectU
//
//  Created by Presto on 2018. 3. 2..
//  Copyright © 2018년 Presto. All rights reserved.
//

import BRYXBanner

extension Banner{
    static func make(title: String, subtitle: String, image: UIImage, backgroundColor: UIColor) -> Banner{
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: backgroundColor, didTapBlock: nil)
        banner.dismissesOnTap = true
        return banner
    }
}
