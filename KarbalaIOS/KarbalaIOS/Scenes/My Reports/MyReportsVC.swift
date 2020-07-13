//
//  MyReportsVC.swift
//  Amanaksa
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class MyReportsVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var reportsCollectionView: UICollectionView!
    
    internal let cellIdentifier = "ReportCell"
    internal let sectionIdentifier = "MarginSectionCell"
    
    var presenter:MyReportsVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = MyReportsVCPresenter(delegate:self)
        presenter.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func filter(_ sender: UIButton) {
        presenter.changeFilter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.AppSegues.fromReportsToDetails.rawValue{
            let reportDetailsVC = segue.destination as? ReportDetailsVC
            reportDetailsVC?.reportId = sender as? Int
        }
        
    }
    
}
//MARK:- Setup UI
extension MyReportsVC{
    func setupUI(){
        setupTextField()
        setupCollectionView()
    }
    
    func setupTextField(){
        searchTextField.addTarget(self, action: #selector(SearchTextFieldChanged), for: .editingChanged)
        searchTextField.placeholder = "Search for report".localized
        searchTextField.delegate = self
    }
    
    @objc func SearchTextFieldChanged(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presenter.changeSearchName(word: self.searchTextField.text ?? "")
        }
    }
    
}

extension MyReportsVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
