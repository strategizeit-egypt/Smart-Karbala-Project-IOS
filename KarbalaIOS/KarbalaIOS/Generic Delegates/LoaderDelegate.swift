//
//  LoaderDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol LoaderDelegate:ErrorDelegate {
    func showLoader()
    func hideLoader()
}

