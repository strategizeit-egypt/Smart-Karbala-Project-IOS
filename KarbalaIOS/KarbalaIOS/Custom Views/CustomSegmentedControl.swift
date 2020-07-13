//
//  CustomSegmentedControl.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    
    var buttons:[UIButton] = [UIButton]()
    var selector:UIView!
    private let font = UIFont().regularFont(with: 17)
    var selectedIndex:Int?{
        didSet{
            selector.isHidden = false
        }
    }
    
    @IBInspectable
    var commaSeperatedTitles:String = ""{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectedTextColor:UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var textColor:UIColor = UIColor.OnyxTextColor{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor:UIColor = UIColor.buttonBackgroundColor{
        didSet{
            updateView()
        }
    }
    
    override func draw(_ rect: CGRect) {
        //layer.cornerRadius = frame.height / 2
    }
    
    func updateView(){
        
        buttons.removeAll()
        subviews.forEach {
            $0.removeFromSuperview()
        }
        
        let buttonTitles = commaSeperatedTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.backgroundColor = .white
            button.titleLabel?.font = font
            button.layer.cornerRadius = button.frame.size.height / 2
            button.contentEdgeInsets.bottom = 5
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .center
            button.addTarget(self, action: #selector(buttonTabbed(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth - 8 , height: frame.height))
        selector.backgroundColor = selectorColor
        selector.layer.cornerRadius = frame.height / 2
        selector.isHidden = (selectedIndex == nil)
        addSubview(selector)
        
        let hStackButtons = UIStackView(arrangedSubviews: buttons)
        hStackButtons.alignment = .fill
        hStackButtons.distribution = .fillEqually
        hStackButtons.axis = .horizontal
        hStackButtons.spacing = 8
        addSubview(hStackButtons)
        
        hStackButtons.translatesAutoresizingMaskIntoConstraints = false
        hStackButtons.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        hStackButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        hStackButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        hStackButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
       
        subviews.forEach {
            $0.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    @objc func buttonTabbed(button:UIButton){
        for (buttonIndex,btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            if btn == button{
                selectedIndex = buttonIndex
                let selectorStartPosition = (frame.width / CGFloat(buttons.count)) * CGFloat(buttonIndex)
                print(selectorStartPosition)
                UIView.animate(withDuration: 0.3) {
                    self.selector.frame.origin.x = selectorStartPosition
                }
                btn.setTitleColor(selectedTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
}
