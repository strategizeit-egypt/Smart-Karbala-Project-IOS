//
//  ErrorDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ErrorDelegate:NSObjectProtocol {
    func showError(message:String)
    func showError(error:ApiError)
}
