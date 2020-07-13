//
//  VerificationVC + TextFields.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
extension VerificationVC:UITextFieldDelegate{

    //MARK:- Setup
    func setupTextFields(){
        [textField1,textField2,textField3,textField4].forEach {
            $0?.delegate = self
        }
    }
    
    //MARK:- Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.count)! == 0 && (string.count == 1) {
            if textField == textField1{
                textField2.becomeFirstResponder()
            }else if textField == textField2{
                textField3.becomeFirstResponder()
            }else if textField == textField3{
                textField4.becomeFirstResponder()
            }else if textField == textField4{
                textField4.resignFirstResponder()
            }
            textField.text = string.convertArabicNumberToEnglishNumber
            return false
        }else if (textField.text?.count)! == 1 && (string.count == 0){
            if textField == textField2{
                textField1.becomeFirstResponder()
            }else if textField == textField3{
                textField2.becomeFirstResponder()
            }else if textField == textField4{
                textField3.becomeFirstResponder()
            }else if textField == textField1{
                textField1.resignFirstResponder()
            }
            textField.text = string.convertArabicNumberToEnglishNumber
            return false
        }else if (textField.text?.count)! == 1 && (string.count == 1){
            if textField == textField2{
                textField1.becomeFirstResponder()
            }else if textField == textField3{
                textField2.becomeFirstResponder()
            }else if textField == textField4{
                textField3.becomeFirstResponder()
            }else if textField == textField1{
                textField1.resignFirstResponder()
            }
            textField.text = string.convertArabicNumberToEnglishNumber
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        notifyPresenterToVerfiyCode()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("clear")
        return true
    }
    
    
}
