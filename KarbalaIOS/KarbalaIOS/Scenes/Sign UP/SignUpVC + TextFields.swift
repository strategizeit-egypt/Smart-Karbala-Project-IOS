//
//  SignUpVC + TextFields.swift
//  KarbalaIOS
//
//  Created by mac on 3/30/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import CountryPickerView

extension SignUpVC:UITextFieldDelegate{
    
    //MARK:- Setup
    func setupTextFields(){
        countryCodeTextField.rightImage = UIImage(named: "menu")
        countryCodeTextField.semanticContentAttribute = .forceLeftToRight
        [phoneNumberTextField,countryCodeTextField,countryTextField,birthdateTextField,municipalityTextField,nameTextField,emailTextField,cityTextField,neighborhoodTextField,subCountryTextField].forEach {
            $0?.delegate = self
            $0!.addTarget(self, action: #selector(didChangeText(field:)), for: .editingChanged)
        }
        
        setHalfRaduis()
        
        [municipalityTextField,birthdateTextField,countryTextField,subCountryTextField].forEach {
            if UIApplication.isRTL(){
                $0?.leftPadding = 20
                $0?.setLeftPaddingPoints(10)
            }else{
                $0?.rightPadding = 20
                $0?.setLeftPaddingPoints(20)
            }
        }
    }
    
    func setHalfRaduis(){
        DispatchQueue.main.async {
            if UIApplication.isRTL(){
                self.setRaduisForRightView(for: self.municipalityTextField)
                self.setRaduisForLeftView(for: self.neighborhoodTextField)
            }else{
                self.setRaduisForLeftView(for: self.municipalityTextField)
                self.setRaduisForRightView(for: self.neighborhoodTextField)
            }
        }
    }
    
    
    func setupCountryCodePicker(){
        countryCodePicker = CountryPickerView()
        countryCodePicker.setCountryByPhoneCode(countryCode ?? "+20")
        countryCodeTextField.text = countryCodePicker.selectedCountry.phoneCode
        if let phoneNumber = phoneNumber{
            self.phoneNumberTextField.text = phoneNumber
        }
        countryCodePicker.delegate = self
        countryCodePicker.dataSource = self
    }
    
    @objc func didChangeText(field: UITextField) {
        if field == phoneNumberTextField{
            field.text = field.text?.convertArabicNumberToEnglishNumber
        }
        checkEmptyTextFields()
    }
    
    func checkEmptyTextFields(){
        [nameTextField,
         emailTextField,birthdateTextField,countryTextField,municipalityTextField,
         neighborhoodTextField,cityTextField,subCountryTextField].forEach { textField in
            self.setBorderColor(for: textField!)
        }
        if phoneNumberTextField!.isTextFieldEmpty(){
            phoneView.borderColor = .TomatoTextColor
        }else{
            phoneView.borderColor = UIColor.colorFromHexString("707070")
        }
        
    }
    
    func setBorderColor(for textField:UITextField){
        let borderColor = (textField.isTextFieldEmpty() ? .TomatoTextColor : UIColor.colorFromHexString("707070"))

        if textField == municipalityTextField{
            if UIApplication.isRTL(){
                self.setRaduisForRightView(with: borderColor,for: textField)
            }else{
                self.setRaduisForLeftView(with: borderColor,for: textField)
            }
        }else if textField == neighborhoodTextField{
            if UIApplication.isRTL(){
                self.setRaduisForLeftView(with: borderColor,for: textField)
            }else{
                self.setRaduisForRightView(with: borderColor,for: textField)
            }
        }else{
           textField.borderColor = borderColor
        }
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
            countryCodePicker.showCountriesList(from: self.navigationController!)
        }else if textField == birthdateTextField{
            textField.inputView = birthDatePicker
            birthDatePicker.isHidden = false
        }else if textField == municipalityTextField{
            textField.inputView = municipalityPicker
            municipalityPicker.isHidden = false
        }else if textField == countryTextField{
            textField.inputView = countryPicker
            countryPicker.isHidden = false
        }else if textField == subCountryTextField{
            textField.inputView = subcountryPicker
            subcountryPicker.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == birthdateTextField{
            birthDate = birthDatePicker.date
            textField.text = Date.convertDateToString(date: birthDatePicker.date, dateFormateString: AppConstants.birthDateFormate)
            checkEmptyTextFields()
        }else if textField == municipalityTextField || textField == countryTextField || textField == subCountryTextField{
            checkEmptyTextFields()
        }
        textField.resignFirstResponder()
    }
    
}

extension SignUpVC:CountryPickerViewDelegate,CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryCodeTextField.text = country.phoneCode
    }
    
}

