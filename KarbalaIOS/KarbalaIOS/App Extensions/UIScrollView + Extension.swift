//
//  UIScrollView + Extension.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView{
    func addRefresherToScrollView(){
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.buttonBackgroundColor
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
    }
}
