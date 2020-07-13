//
//  BaseVC.swift
//  Amanaksa
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class BaseVC: UNDPViewController {

    var shapeImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        // Do any additional setup after loading the view.
    }

}

extension BaseVC{
    
    func setImageView(){
        shapeImageView = UIImageView(image: UIImage(named: UIApplication.isRTL() ? "method-draw-image-ar" : "method-draw-image"))
        shapeImageView.contentMode = .scaleToFill
        self.view.addSubview(shapeImageView)
        shapeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        var statusBarHeight:CGFloat = 0
        let navBarHeight = (self.navigationController?.navigationBar.frame.height ?? 40) + 20
        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 40
        }else{
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        
        shapeImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        shapeImageView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: statusBarHeight).isActive = true
        shapeImageView.heightAnchor.constraint(equalToConstant: navBarHeight).isActive = true
        self.view.sendSubviewToBack(shapeImageView)
    }
    
    func changeImageTint(){
        shapeImageView.image = shapeImageView.image?.withRenderingMode(.alwaysTemplate)
        shapeImageView.tintColor = UIColor.KarbalaBackgroundColor
    }
}
