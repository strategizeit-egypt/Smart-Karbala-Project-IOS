//
//  LanguageVC.swift
//  Amanaksa
//
//  Created by mac on 2/24/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LanguageVC: BaseVC {
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var languageTableView: UITableView!
    
    
    private let cellIdentifier = "RadioCell"
    private let sectionIdentifier = "MarginSectionCell"
    private let items:[Item] = [Item(image: "about_us", name: "English", description: "Change language to english"),
                                Item(image: "about_us", name: "عربي".localized, description: "تغيير اللغة إلي اللغة العربية")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeImageTint()
        setupUI()
    }
    
    
    @IBAction func changeLanguage(_ sender: UIButton) {
        guard let selectedIndex = languageTableView.indexPathsForSelectedRows?.first else{
            return
        }
        
        selectedIndex.section == 0 ? setEnglish() : setArabic()
    }
    
    func setEnglish(){
        let transition: UIView.AnimationOptions = .transitionFlipFromRight
        
        if !UIApplication.isRTL() {
            
        }else{
            L102Language.setAppleLAnguageTo(lang: "en")
        }
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        animateView(with: transition)
    }
    
    func setArabic(){
        let transition: UIView.AnimationOptions = .transitionFlipFromLeft
        if UIApplication.isRTL() {
            
        }else{
            L102Language.setAppleLAnguageTo(lang: "ar")
        }
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        animateView(with: transition)
    }
    
    func animateView(with transition:UIView.AnimationOptions){
        let rootviewcontroller: UIWindow = UIApplication.shared.windows.first!
        rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeStart")
        let mainwindow = UIApplication.shared.windows.first!
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    
    
}

//MARK:- Setup UI
extension LanguageVC{
    func setupUI(){
        setupTableView()
        changeButton.setTitle("Change".localized, for: .normal)
    }
    
    func setupTableView(){
        languageTableView.backgroundColor = UIColor.clear
        languageTableView.delegate = self
        languageTableView.dataSource = self
        languageTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    
}

//MARK:- Table View Data source & Delegate
extension LanguageVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RadioCell
        if indexPath.section == 0{
            cell.setupCell(item: items[0])
            cell.delegate = self
            if !UIApplication.isRTL(){tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)}
        }else{
            if UIApplication.isRTL(){tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)}
            cell.delegate = self
            cell.setupCell(item: items[1])
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        
    }
    
}

extension LanguageVC:RadioCellDelegate{
    func didTapRadioButton(cell: RadioCell) {
        if let deselectedIndexPath = languageTableView.indexPathForSelectedRow{
            languageTableView.deselectRow(at: deselectedIndexPath, animated: true)
            languageTableView.cellForRow(at: deselectedIndexPath)?.isSelected = false
        }
        
        guard let indexPath = languageTableView.indexPath(for: cell) else{ return }
        languageTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        cell.isSelected = true
    }
    
    
}
