//
//  LoginVC + BoxDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import BEMCheckBox

extension LoginVC:BEMCheckBoxDelegate,TermsVCDelegate{
    
    //MARK:- Bem Box Delegate
    func setupBemCheckBox(){
        termsRadioBox.delegate = self
        termsRadioBox.boxType = .square
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        if termsRadioBox.on{
            termsRadioBox.on = false
            navigateToTerms()
        }
    }
    
    //MARK:- Terms VC Delegate
    func didAcceptTerms() {
        termsRadioBox.on = true
    }
}

