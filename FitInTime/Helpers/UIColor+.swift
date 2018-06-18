//
//  UIColor+theme.swift
//  UITableViewSample
//
//  Created by Joffrey Fortin on 26/04/2018.
//  Copyright © 2018 Joffrey Fortin. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let someColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
    
    static let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
    
    static let darkBlue = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
    
    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
    
    static let doneGreen = rgb(r: 20, g: 187, b: 112)
    
    
    static let orangeCustom = rgb(r: 254, g: 131, b: 7)
    static let roseCustom = rgb(r: 233, g: 46, b: 111)
    static let blueCustom = rgb(r: 21, g: 126, b: 251)
    
    
}
