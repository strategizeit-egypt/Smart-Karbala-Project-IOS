//
//  AboutUsVC.swift
//  Amanaksa
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AboutUsVC: BaseVC {
    
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension AboutUsVC{
    
    func setupUI(){
        setupTextView()
        aboutTextView.text = UIApplication.isRTL() ? Helper.getValue(by: "aboutusar") : Helper.getValue(by: "aboutus")
    }
    
    func setupTextView(){
        aboutTextView.backgroundColor = .clear
        aboutTextView.textContainerInset = UIEdgeInsets(top: 25, left: 20, bottom: 20, right: 20)
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.white.cgColor, UIColor.colorFromHexString("fcf8e7").cgColor,UIColor.KarbalaBackgroundColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.locations = [0.05,0.65,1]
        gradient.frame = self.aboutTextView.bounds

        self.aboutTextView.layer.insertSublayer(gradient, at: 0)
    }
}
