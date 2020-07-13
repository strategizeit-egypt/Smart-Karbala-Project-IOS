//
//  LoginVC + TextFields.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import CountryPickerView

extension LoginVC:UITextFieldDelegate{
    
    //MARK:- Setup
    func setupTextFields(){
        countryCodeTextField.rightImage = UIImage(named: "menu")
        countryCodeTextField.semanticContentAttribute = .forceLeftToRight
        [phoneNumberTextField,countryCodeTextField].forEach {
            $0?.delegate = self
        }
        phoneNumberTextField.addTarget(self, action: #selector(didChangeText(field:)), for: .editingChanged)
        
    }
    
    func setupCountryPicker(){
        countryPicker = CountryPickerView()
        countryPicker.setCountryByPhoneCode("+20")
        countryCodeTextField.text = countryPicker.selectedCountry.phoneCode
        countryPicker.delegate = self
        countryPicker.dataSource = self
    }
    
    @objc func didChangeText(field: UITextField) {
        field.text = field.text?.convertArabicNumberToEnglishNumber
    }
    
    
    //MARK:- Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField{
            return checkAllowedCharacters(text: string)
        }
        return true
    }
    
    func checkAllowedCharacters(text:String)->Bool{
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet.init(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == countryCodeTextField{
            textField.resignFirstResponder()
            countryPicker.showCountriesList(from: self)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}

extension LoginVC:CountryPickerViewDelegate,CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryCodeTextField.text = country.phoneCode
    }
    
    
    
}
