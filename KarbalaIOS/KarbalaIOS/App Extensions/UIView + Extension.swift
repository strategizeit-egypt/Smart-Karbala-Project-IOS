//
//  UIView + Extension.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
//MARK:- UIView
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var isRounded: Bool {
        set{
            layer.cornerRadius = (newValue == true) ? (frame.size.height / 2) : 0
        }get{
            return self.isRounded
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
    }
    
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
    
}

protocol RoundedBorderProtocol: class {
    func makeBorder(with radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor,corners: UIRectCorner)
}

extension UIView: RoundedBorderProtocol {
    func makeBorder(with radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor,corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        // Create the shape layer and set its path
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath

        // Set the newly created shape layer as the mask for the view's layer
        layer.mask = maskLayer

        //Create path for border
        let borderPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        // Create the shape layer and set its path
        let borderLayer = CAShapeLayer()

        borderLayer.frame = bounds
        borderLayer.path = borderPath.cgPath
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor

        //The border is in the center of the path, so only the inside is visible.
        //Since only half of the line is visible, we need to multiply our width by 2.
        borderLayer.lineWidth = borderWidth * 2

        //Add this layer to display the border
        layer.addSublayer(borderLayer)
    }
}
