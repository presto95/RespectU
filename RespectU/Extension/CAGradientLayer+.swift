//
//  CAGradientLayer+.swift
//  RespectU
//
//  Created by Presto on 13/10/2018.
//  Copyright © 2018 Presto. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    static func makeGradient(startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor], locations: [NSNumber]) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colors
        gradient.locations = locations
        return gradient
    }
}
