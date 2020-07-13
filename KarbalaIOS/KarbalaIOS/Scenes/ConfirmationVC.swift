//
//  ConfirmationVC.swift
//  Amanaksa
//
//  Created by mac on 3/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ConfirmationVC: UIViewController {
    
    @IBOutlet weak var successfullyLabel: UILabel!
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        popToMyReports()
    }
    
}

//MARK:- UI Setup
extension ConfirmationVC{
    
    func setupUI(){
        localizeComponets()
        setTermsAndConditionsStyle()
        addActionToBackHomeLabel()
    }
    
    func localizeComponets(){
        homeLabel.text = "msg_need_back".localized
        successfullyLabel.text = "Successfully".localized
        thanksLabel.text = "msg_send_report_successfully".localized
    }
    
    func setTermsAndConditionsStyle(){
        let mainText = "msg_need_back".localized
        let subText = "act_home_screen".localized
        let range = (mainText as NSString).range(of: subText)
        let attributedString = NSMutableAttributedString(string: mainText)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.buttonBackgroundColor,NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,NSAttributedString.Key.underlineColor:UIColor.buttonBackgroundColor], range: range)
        DispatchQueue.main.async {
            self.homeLabel.attributedText = attributedString
        }
    }
    
    func addActionToBackHomeLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popToRoot))
        tapGesture.numberOfTapsRequired = 1
        homeLabel.isUserInteractionEnabled = true
        homeLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func popToRoot(){
        guard let mapVC = self.navigationController?.viewControllers[0] as? MapVC else{
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        self.navigationController?.popToViewController(mapVC, animated: true)
        
    }
    
    func popToMyReports(){
        guard let mapVC = self.navigationController?.viewControllers[0] as? MapVC else{
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        mapVC.isBackFromConfirmation = true
        self.navigationController?.popToViewController(mapVC, animated: true)
        
    }
}
