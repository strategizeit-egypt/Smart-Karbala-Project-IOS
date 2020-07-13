//
//  ReportCategoryVC.swift
//  KarbalaIOS
//
//  Created by mac on 5/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ChooseReportCategoryVcDelegate:NSObjectProtocol {
    func didSelectReportType(type:ReportTypes)
}

class ReportCategoryVC: BaseVC {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    weak var delegate:ChooseReportCategoryVcDelegate?
    internal let cellIdentifier = "MoreItemCell"
    internal let sectionIdentifier = "MarginSectionCell"

    var presenter:ChooseReportCategoryVCPresenter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeImageTint()
        setupCollectionView()
        presenter = ChooseReportCategoryVCPresenter(delegate: self)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.AppSegues.fromReportCategoryToReportSubcategory.rawValue{
            let vc = segue.destination as! ChooseReportTypeVC
            vc.delegate = self
            vc.reportCategory = sender as? ReportTypeCategories
        }
    }

}

extension ReportCategoryVC:ChooseReportTypeVcDelegate{
    func didSelectReportType(type: ReportTypes) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.didSelectReportType(type: type)
    }
}
