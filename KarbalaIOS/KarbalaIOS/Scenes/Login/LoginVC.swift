//
//  LoginVC.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import BEMCheckBox
import CountryPickerView

class LoginVC: UNDPViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInDescLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var countryCodeTextField: DesignableUITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var termsRadioBox: BEMCheckBox!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var presenter:LoginVCPresenter!
    var countryPicker:CountryPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = LoginVCPresenter.init(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func login(_ sender: UIButton) {
        view.endEditing(true)
        presenter.registerWithNameAndPhone(countryRegion: countryPicker.selectedCountry.code, phoneNumber: phoneNumberTextField.text, isAcceptTerms: termsRadioBox.on)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        view.endEditing(true)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromLoginToSignup.rawValue, sender: nil)
    }
    
}

//MARK:- UI Setup
extension LoginVC{
    
    func setupUI(){
        setupTextFields()
        localizeComponets()
        forcePhoneViewToLeftDirection()
        setupBemCheckBox()
        setTermsAndConditionsStyle()
        setupCountryPicker()
    }
    
    //MARK:- Localization
    func localizeComponets(){
        phoneNumberTextField.placeholder = "phone_text_field_placeholder".localized
        
        signInLabel.text = "sign_in_label".localized
        signInDescLabel.text = "sign_in_desc".localized
        
        welcomeLabel.text = "welcome_header".localized
        
        signUpLabel.text = "don't_have_account".localized
        signUpButton.setTitle("signup_button".localized, for: .normal)
        termsLabel.text = "terms_label".localized
        
    }
    
    
    //MARK:- Phone View Direction
    func forcePhoneViewToLeftDirection(){
        phoneView.semanticContentAttribute = .forceLeftToRight
        phoneStackView.semanticContentAttribute = .forceLeftToRight
    }
    
    //MARK:- Terms Label
    func setTermsAndConditionsStyle(){
        let mainText = "terms_label".localized
        let subText = "Terms and conditions".localized
        let range = (mainText as NSString).range(of: subText)
        let attributedString = NSMutableAttributedString(string: mainText)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.buttonBackgroundColor,NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,NSAttributedString.Key.underlineColor:UIColor.buttonBackgroundColor], range: range)
        DispatchQueue.main.async {
            self.termsLabel.attributedText = attributedString
        }
    }
    
    func addActionToTermsLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToTerms))
        tapGesture.numberOfTapsRequired = 1
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(tapGesture)
    }
    
}





