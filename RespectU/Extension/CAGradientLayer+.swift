//
//  CAGradientLayer+.swift
//  RespectU
//
//  Created by Presto on 11/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    static func makeGradient(colors: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.colors = colors
        gradient.locations = locations
        return gradient
    }
}
