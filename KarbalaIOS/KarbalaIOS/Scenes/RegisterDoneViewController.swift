//
//  RegisterDoneViewController.swift
//  KarbalaIOS
//
//  Created by mac on 5/6/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol RegisterDoneViewControllerDelegate:NSObjectProtocol {
    func didTapOneDoneButton(user:UserModel)
}

class RegisterDoneViewController: UIViewController {

    @IBOutlet weak var doneButton: KarbalaButton!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var registerDoneLabel: UILabel!
    
    var user:UserModel!
    weak var delegate:RegisterDoneViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeComponents()
    }
    
    func localizeComponents(){
        doneButton.setTitle("ok".localized, for: .normal)
        userIdLabel.text = "msg_user_number %@".localizeStringWithParams(params: ["\(user.id)"])
        registerDoneLabel.text = "msg_successfull_rigster".localized
    }
    
    @IBAction func done(_ sender: KarbalaButton) {
        delegate?.didTapOneDoneButton(user: user)
    }
    
}
