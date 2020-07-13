//
//  TermsVC.swift
//  Amanaksa
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol TermsVCDelegate:NSObjectProtocol {
    func didAcceptTerms()
}

class TermsVC: BaseVC {
    
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var checkBarButton: UIBarButtonItem!
    
    var isTermsAndCondtionsScreen = true
    weak var delegate:TermsVCDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func acceptTerms(_ sender: UIBarButtonItem) {
        delegate?.didAcceptTerms()
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension TermsVC{
    
    func setupUI(){
        setupTextView()
        if !isTermsAndCondtionsScreen{
            self.checkBarButton.isEnabled = false
            self.checkBarButton.tintColor = .clear
        }
    }
    
    func setupTextView(){
        termsTextView.text = UIApplication.isRTL() ? Helper.getValue(by: "termsandconditionsar") : Helper.getValue(by: "termsandconditions")
        termsTextView.backgroundColor = .white
        termsTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

}
