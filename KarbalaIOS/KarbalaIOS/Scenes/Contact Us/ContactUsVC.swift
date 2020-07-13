//
//  ContactUsVC.swift
//  Amanaksa
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class ContactUsVC: BaseVC {
    
    @IBOutlet weak var messageTitleTextField: UITextField!
    @IBOutlet weak var messageBodyTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var contactByLabel: UILabel!
    @IBOutlet weak var hotLineLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var whatsAppLabel: UILabel!
    @IBOutlet weak var messengerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var hotLineStackView: UIStackView!
    @IBOutlet weak var websiteLabel: UILabel!

    var presenter:ContactusVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeImageTint()
        setupUI()
        presenter = ContactusVCPresenter(delegate:self)
    }
    
    
    @IBAction func sendMessage(_ sender: UIButton) {
        messageTitleTextField.resignFirstResponder()
        messageBodyTextView.resignFirstResponder()
        presenter.validateContactusParamters(title: messageTitleTextField.text, body: messageBodyTextView.text)
    }
    

    @IBAction func contactUsBy(_ sender: UIButton) {
        if sender.tag == 0{
            presenter.tapWhatsAppIcon()
        }else if sender.tag == 1{
            presenter.tapTwitterIcon()
        }else if sender.tag == 2{
            presenter.tapEmailIcon()
        }else{
            presenter.tapWebsite()
        }
    }
    
}

//MARK:- Setup UI
extension ContactUsVC{
    
    func setupUI(){
        setupTextView()
        localizeComponets()
        addActionToHotLineStackView()
    }
    
    func addActionToHotLineStackView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(callHotLine))
        hotLineLabel.isUserInteractionEnabled = false
        phoneNumberLabel.isUserInteractionEnabled = false
        tapGesture.numberOfTapsRequired = 1
        hotLineStackView.isUserInteractionEnabled = true
        hotLineStackView.addGestureRecognizer(tapGesture)
    }
    
    func setupTextView(){
        messageBodyTextView.backgroundColor = .white
        messageBodyTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func localizeComponets(){
        messageTitleTextField.placeholder = "message_title_placeholder".localized
        messageBodyTextView.placeholder = "message_body_placeholder".localized
        sendButton.setTitle("send_button".localized, for: .normal)
        contactByLabel.text = "contact_by".localized
        
        hotLineLabel.text = "hot_line".localized
        whatsAppLabel.text = "Whatsapp".localized
        messengerLabel.text = "Messenger".localized
        emailLabel.text = "E-Mail".localized
        websiteLabel.text = "website".localized

    }
    
    @objc func callHotLine(){
        presenter.tapHotLine()
    }
    
}

