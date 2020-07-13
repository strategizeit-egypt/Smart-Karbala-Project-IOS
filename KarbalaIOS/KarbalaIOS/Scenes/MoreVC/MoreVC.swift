//
//  MoreVC.swift
//  Amanaksa
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class MoreVC: BaseVC {
    
    @IBOutlet weak var moreCollectionView: UICollectionView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var PlaneImageView: UIImageView!
    @IBOutlet weak var signOutStackView: UIStackView!
    @IBOutlet weak var signoutLabel: UILabel!
   
    internal let cellIdentifier = "MoreItemCell"
    internal let sectionIdentifier = "MarginSectionCell"
    var presenter:MoreVCPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = MoreVCPresenter(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func editName(_ sender: UIButton) {
        if sender == editButton{
            isNameEditable(isEditable: true)
        }else if sender == doneButton{
            presenter.editFullName(fullName: nameTextField.text)
        }else{
            presenter.populateUserName()
            isNameEditable(isEditable: false)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.AppSegues.fromMoreToTerms.rawValue{
            let termsVC = segue.destination as! TermsVC
            termsVC.isTermsAndCondtionsScreen = false
        }
    }
    
}

//MARK:- Setup UI
extension MoreVC{
    func setupUI(){
        signoutLabel.text = "Sign out".localized
        setupCollectionView()
        nameTextField.delegate = self
        isNameEditable(isEditable: false)
        addActionToSignoutStackView()
    }
    
    func addActionToSignoutStackView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSignOut))
        tapGesture.numberOfTapsRequired = 1
        signOutStackView.isUserInteractionEnabled = true
        signOutStackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapSignOut(){
        self.showDefaultAlert(firstButtonTitle: "ok".localized, secondButtonTitle: "cancel".localized, title: "Confirm".localized, message: "logout_confirmation".localized) { [weak self](logout) in
            guard let self = self else{return}
            if logout{
                self.presenter.logoutFromApp()
            }else{
                
            }
        }
    }
    
    
    func isNameEditable(isEditable:Bool){
        DispatchQueue.main.async {
            self.editButton.isHidden = isEditable
            self.closeButton.isHidden = !isEditable
            self.doneButton.isHidden = !isEditable
            self.nameTextField.isEnabled = isEditable
            if isEditable{
                self.nameTextField.becomeFirstResponder()
            }else{
                self.nameTextField.resignFirstResponder()
            }
        }
    }
    
}

extension MoreVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.editFullName(fullName: textField.text)
        return true
    }
}
