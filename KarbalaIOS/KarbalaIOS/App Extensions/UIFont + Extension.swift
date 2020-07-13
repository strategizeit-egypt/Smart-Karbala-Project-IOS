//
//  UIFont + Extensions.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    func boldFont(with size:CGFloat)->UIFont{
        return UIFont(name: AppConstants.AppConstantsEnum.regularFont.mappingValue, size: size)!
    }
    
    func regularFont(with size:CGFloat)->UIFont{
        return UIFont(name: AppConstants.AppConstantsEnum.regularFont.mappingValue, size: size)!
    }
}
