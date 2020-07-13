//
//  UNDPViewController.swift
//  KarbalaIOS
//
//  Created by mac on 5/6/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UNDPViewController: UIViewController {
    var undpLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUNDPLabel()
        // Do any additional setup after loading the view.
    }
    
    
    func setUNDPLabel(){
        undpLabel = UILabel()
        undpLabel.font = UIFont().regularFont(with: 13)
        undpLabel.text = "msg_brought_to_you".localized
        view.addSubview(undpLabel)
        undpLabel.translatesAutoresizingMaskIntoConstraints = false
        undpLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        undpLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20).isActive = true
        undpLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -15).isActive = true
        self.view.sendSubviewToBack(undpLabel)
    }
    
}
