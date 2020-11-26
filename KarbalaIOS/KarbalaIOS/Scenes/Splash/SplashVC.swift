//
//  SplashVC.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

//MARK:- TASKS
/**
 1- choose App Language if it's first time for user in the app
 2- Localize View
 3-
 */

class SplashVC: UNDPViewController {
    
    @IBOutlet weak var xappsLabel: UILabel!
    @IBOutlet weak var arabicButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var languageView: UIView!

    var presenter:SplashVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SplashVCPresenter(delegate: self)
        presenter.viewDidLoad()
        setupUI()
    }
    
   //english == 1 , arabic == 2
    @IBAction func selectAppLanguage(_ sender: UIButton) {
        if sender.tag == 1{
            setSelectedStyle(for: sender, isSelected: true)
            setSelectedStyle(for: arabicButton, isSelected: false)
        }else{
            setSelectedStyle(for: englishButton, isSelected: false)
            setSelectedStyle(for: sender, isSelected: true)
        }
        AppConstants.shared.saveIsLanguageSelectedKeyInUserDefaults()
        setAppLanguage(isArabic: sender.tag == 1 ? false : true)
        presenter.didSelectLanguage()
    }
    
}

//MARK:- UI Setup
extension SplashVC{
    
    func setupUI(){
        undpLabel.textAlignment = .center
        localizeComponets()
        xappsLabel.isHidden = false
        [arabicButton,englishButton].forEach {
            setSelectedStyle(for: $0, isSelected: false)
        }
    }
    
    // Check if user select languae before to show or hide language Segmented Control
    func isFirstTimeForUserInApp(isFirstTime:Bool){
//        languageSegmentedControl.isHidden = !isFirstTime
        languageView.isHidden = !isFirstTime
    }
    
    func setSelectedStyle(for button:UIButton , isSelected:Bool){
        button.backgroundColor = (isSelected ? .buttonBackgroundColor : .white)
        button.setTitleColor((isSelected ? .white : .black), for: .normal)
    }
    
    func localizeComponets(){
        xappsLabel.text = "splash_sentence".localized
    }
    
    func setAppLanguage(isArabic:Bool){
        if isArabic{
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        self.localizeComponets()
    }
    
}

