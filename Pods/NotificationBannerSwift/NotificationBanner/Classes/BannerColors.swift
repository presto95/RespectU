/*
 
 The MIT License (MIT)
 Copyright (c) 2017 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

import UIKit

public protocol BannerColorsProtocol {
    func color(for style: BannerStyle) -> UIColor
}

public class BannerColors: BannerColorsProtocol {

    public func color(for style: BannerStyle) -> UIColor {
        switch style {
        case .portable1:
            return UIColor(red: 29/255.0, green: 180/255.0, blue: 210/255.0, alpha: 1)
        case .portable2:
            return UIColor(red: 252/255.0, green: 34/255.0, blue: 43/255.0, alpha: 1)
        case .respect:
            return UIColor(red: 240/255.0, green: 179/255.0, blue: 44/255.0, alpha: 1)
        case .trilogy:
            return UIColor(red: 115/255.0, green: 139/255.0, blue: 252/255.0, alpha: 1)
        case .ce:
            return UIColor(red: 255/255.0, green: 248/255.0, blue: 221/255.0, alpha: 1)
            
            case .danger:   return UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
            case .info:     return UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
            case .none:     return UIColor.clear
            case .success:  return UIColor(red:0.22, green:0.80, blue:0.46, alpha:1.00)
            case .warning:  return UIColor(red:1.00, green:0.66, blue:0.16, alpha:1.00)
        }
    }
}
