//
//  SignUpVC.swift
//  KarbalaIOS
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CountryPickerView

class SignUpVC: BaseVC {
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeDescLabel: UILabel!
    
    @IBOutlet weak var userTypeView: UIView!
    
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userTypeHintLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var countryCodeTextField: DesignableUITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var addressStackView: UIStackView!
    @IBOutlet weak var municipalityTextField: DesignableUITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var neighborhoodTextField: UITextField!
    @IBOutlet weak var birthdateTextField: DesignableUITextField!
    @IBOutlet weak var countryTextField: DesignableUITextField!
    @IBOutlet weak var subCountryTextField: DesignableUITextField!

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var citizenButton: KarbalaButton!
    @IBOutlet weak var visitorButton: KarbalaButton!

    
    var phoneNumber:String?
    var countryCode:String?
    var countryCodePicker:CountryPickerView!
    
    lazy var municipalityPicker = UIPickerView()
    var municipalityId:Int?
    
    lazy var birthDatePicker = UIDatePicker()
    var birthDate = Date(timeIntervalSinceNow: -18 * 356 * 24 * 60 * 60)
    
    lazy var countryPicker = UIPickerView()
    var countryId:Int?{
        didSet{
            if let id = countryId , id == 1{
                self.subCountryTextField.isHidden = false
            }else{
                subcountryId = nil
                self.subCountryTextField.isHidden = true
            }
        }
    }
    
    lazy var subcountryPicker = UIPickerView()
    var subcountryId:Int?

    var presenter:SignupVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignupVCPresenter(delegate: self)
        setupUI()
        self.changeImageTint()
    }
    
    @IBAction func selectUserType(_ sender: UIButton) {
        self.showOrHideBaseOnUserType(for: sender.tag)
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        self.changeGenderImages(for: sender.tag)
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        var params:[String:Any] = [
            "PhoneNumber":phoneNumberTextField.text!,
            "FullName":nameTextField.text!,
            "Email":emailTextField.text!,
            "DateOfBirth":birthdateTextField.text!,
            "CitizenTypeId":presenter.getUserTypeId(),
        ]
        
        if presenter.getUserTypeId() == 1{
            //Visitor
            params["CountryId"] = countryId
            params["GovernorateId"] = subcountryId
        }else{
            //Citizen
            params["City"] = cityTextField.text!
            params["Neighborhood"] = neighborhoodTextField.text!
            params["MunicipalityId"] = municipalityId
        }
        
        presenter.register(params: params, countryRegion: countryCodePicker.selectedCountry.code)
        
    }
    
}

//MARK:- Setup
extension SignUpVC{
    func setupUI(){
        forcePhoneViewToLeftDirection()
        setupTextFields()
        setupCountryCodePicker()
        localizeComponets()
        setTitleInsetsForGenderButtons()
        showOrHideBaseOnUserType(for: citizenButton.tag)
        setBirthDatePicker()
        setPickerViews()
    }
    
    //MARK:- Localization
    func localizeComponets(){
        welcomeLabel.text = "welcome_header".localized
        welcomeDescLabel.text = "welcome_body".localized
        
        userTypeHintLabel.text = "required_fields_hint".localized
        self.setSinginLocalization(for: "Citizen".localized)
        nameTextField.placeholder = "full_name".localized
        emailTextField.placeholder = "email_address".localized
        birthdateTextField.placeholder = "birth_date".localized
       
        municipalityTextField.placeholder = "district".localized
        cityTextField.placeholder = "area".localized
        subCountryTextField.placeholder = "city".localized
        neighborhoodTextField.placeholder = "neighborhood".localized

        countryTextField.placeholder = "Country".localized
        sendButton.setTitle("send_button".localized, for: .normal)
        maleButton.setTitle("male".localized, for: .normal)
        femaleButton.setTitle("female".localized, for: .normal)
        
        genderLabel.text = "gender".localized
        
        citizenButton.setTitle("Citizen".localized, for: .normal)
        visitorButton.setTitle("Visitor".localized, for: .normal)
    }
    
    func setSinginLocalization(for type:String){
        userTypeLabel.text = "sign_up_as_%@".localizeStringWithParams(params: [type])
    }
    
    //MARK:- Half rounded view
    func setRaduisForLeftView(with borderColor:UIColor = .gray,for textField:UITextField){
        textField.makeBorder(with: textField.frame.height / 2, borderWidth: 1, borderColor: borderColor, corners:  [.topLeft,.bottomLeft])
    }
    
    func setRaduisForRightView(with borderColor:UIColor = .gray,for textField:UITextField){
        textField.makeBorder(with: textField.frame.height / 2, borderWidth: 1, borderColor: borderColor, corners: [.topRight,.bottomRight])
    }
    
    //MARK:- Phone View Direction
    func forcePhoneViewToLeftDirection(){
        phoneView.semanticContentAttribute = .forceLeftToRight
        phoneStackView.semanticContentAttribute = .forceLeftToRight
    }
    
    //Mark:- User Type Buttons Style
    func setSelectedStyle(for button:UIButton , isSelected:Bool){
        button.backgroundColor = (isSelected ? .buttonBackgroundColor : .white)
        button.setTitleColor((isSelected ? .white : .black), for: .normal)
    }
    
    
    func showOrHideBaseOnUserType(for tag:Int){
        presenter.setUserType(id: tag)
        if tag == 1{
            addressStackView.isHidden = true
            countryTextField.isHidden = false
            self.setSinginLocalization(for: "Visitor".localized)
            setSelectedStyle(for: visitorButton, isSelected: true)
            setSelectedStyle(for: citizenButton, isSelected: false)
        }else{
            addressStackView.isHidden = false
            countryTextField.isHidden = true
            self.setSinginLocalization(for: "Citizen".localized)
            setSelectedStyle(for: citizenButton, isSelected: true)
            setSelectedStyle(for: visitorButton, isSelected: false)
        }
    }
    
    //Radio Buttons
    func setTitleInsetsForGenderButtons(){
        if UIApplication.isRTL(){
            [maleButton,femaleButton].forEach {
                $0?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 5, right: 10)
            }
        }else{
            [maleButton,femaleButton].forEach {
                $0?.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 5, right: 0)
            }
        }
    }
    
    func changeGenderImages(for tag:Int){
        presenter.setGenderType(id: tag)
        maleButton.setImage(UIImage(named: (tag == 1 ? "selected-radio":"unselected-radio")), for: .normal)
        femaleButton.setImage(UIImage(named: (tag == 2 ? "selected-radio":"unselected-radio")), for: .normal)
    }
    
    
    //MARK:- setup Picker Views
    func setPickerViews(){
        [municipalityPicker,countryPicker,subcountryPicker].forEach {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    //MARK:- Date Picker View
    func setBirthDatePicker(){
        birthDatePicker.datePickerMode = .date
        birthDatePicker.maximumDate = birthDate
        birthDatePicker.isHidden = true
    }
    
    
    
}

extension SignUpVC:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == municipalityPicker {
            return AppConstants.shared.appMetaData?.municipalities?.count ?? 0
        }else if  pickerView == subcountryPicker{
            return AppConstants.shared.appMetaData?.governorates?.count ?? 0
        }else{
            return AppConstants.shared.appMetaData?.countries?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == municipalityPicker {
            return UIApplication.isRTL() ? AppConstants.shared.appMetaData?.municipalities?[row].nameAR : AppConstants.shared.appMetaData?.municipalities?[row].name
        }else if  pickerView == subcountryPicker{
            return UIApplication.isRTL() ? AppConstants.shared.appMetaData?.governorates?[row].nameAR : AppConstants.shared.appMetaData?.governorates?[row].name
        }else{
            return UIApplication.isRTL() ? AppConstants.shared.appMetaData?.countries?[row].nameAR : AppConstants.shared.appMetaData?.countries?[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == municipalityPicker{
            municipalityTextField.text = UIApplication.isRTL() ? AppConstants.shared.appMetaData?.municipalities?[row].nameAR : AppConstants.shared.appMetaData?.municipalities?[row].name
            municipalityId = AppConstants.shared.appMetaData?.municipalities?[row].id
        }else if pickerView == subcountryPicker{
            subCountryTextField.text = UIApplication.isRTL() ? AppConstants.shared.appMetaData?.governorates?[row].nameAR : AppConstants.shared.appMetaData?.governorates?[row].name
            subcountryId = AppConstants.shared.appMetaData?.governorates?[row].id
        }else{
            countryTextField.text = UIApplication.isRTL() ? AppConstants.shared.appMetaData?.countries?[row].nameAR : AppConstants.shared.appMetaData?.countries?[row].name
            countryId = AppConstants.shared.appMetaData?.countries?[row].id
        }
    }
    
}
