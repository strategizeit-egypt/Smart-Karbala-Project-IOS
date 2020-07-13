//
//  UIColor + Extension.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    static var PapayaWhipBackgroundColor:UIColor{
        return UIColor.colorFromHexString("fbf4d5")
    }
    
    static var buttonBackgroundColor:UIColor{
        return UIColor.colorFromHexString("025FF0")
    }
    
    static var OnyxTextColor:UIColor{
        return UIColor.colorFromHexString("022008")
    }
    
    static var TomatoTextColor:UIColor{
        return UIColor.colorFromHexString("ef5e41")
    }
    
    static var KarbalaBackgroundColor:UIColor{
        return UIColor.colorFromHexString("DCE8FF")
    }
    
    
    
    static func colorFromHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
