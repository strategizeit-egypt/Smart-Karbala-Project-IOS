//
//  VerficationVC.swift
//  Amanaksa
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class VerificationVC: UNDPViewController {
    
    
    @IBOutlet weak var enterVerficationLabel: UILabel!
    @IBOutlet weak var verficationDescLabel: UILabel!
    
    @IBOutlet weak var verficationTimerLabel: UILabel!
    @IBOutlet weak var sendAgainLabel: UILabel!
    
    @IBOutlet weak var textFieldsStackView: UIStackView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var presenter:VerificationVCPresenter!
    var phoneNumerWithCode:String!
    var name:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = VerificationVCPresenter.init(delegate: self)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField1.becomeFirstResponder()
        presenter.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.invalidateTimer()
        if self.isMovingFromParent{
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func verfiyCode(_ sender: Any) {
        notifyPresenterToVerfiyCode()
    }
    
    func notifyPresenterToVerfiyCode(){
        let fields = [textField1,textField2,textField3,textField4].map { (field) -> String in
            return field?.text ?? ""
        }
        presenter.verifyCode(phoneNumberWithCode: phoneNumerWithCode, fieldsText: fields)
    }
    
    
}

//MARK:- UI Setup
extension VerificationVC{
    
    func setupUI(){
        forceTextFieldsStackViewToBeLeft()
        setupTextFields()
        localizeComponets()
        setSendAgainLabelStyle()
        addActionToSendAgainLabel()
        [textField1,textField2,textField3,textField4].forEach {
            $0?.text = "7"
        }
    }
    
    func forceTextFieldsStackViewToBeLeft(){
        textFieldsStackView.semanticContentAttribute = .forceLeftToRight
    }
    
    func localizeComponets(){
        enterVerficationLabel.text = "enter_verfication".localized
        verficationDescLabel.text = "verfication_desc".localized
        sendAgainLabel.text = "send_verfication_again".localized
    }
    
    func setSendAgainLabelStyle(){
        let mainText = "send_verfication_again".localized
        let subText = "Send again".localized
        let range = (mainText as NSString).range(of: subText)
        let attributedString = NSMutableAttributedString(string: mainText)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.buttonBackgroundColor,NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,NSAttributedString.Key.underlineColor:UIColor.buttonBackgroundColor], range: range)
        DispatchQueue.main.async {
            self.sendAgainLabel.attributedText = attributedString
        }
    }
    
    func addActionToSendAgainLabel(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(getVerificationCode))
        sendAgainLabel.isUserInteractionEnabled = true
        sendAgainLabel.addGestureRecognizer(tap)
    }
    
    @objc func getVerificationCode(){
        presenter.sendCodeAgain(phoneNumberWithCode: phoneNumerWithCode, fullName: name)
    }
    
}
