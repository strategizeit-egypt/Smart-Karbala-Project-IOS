//
//  ChooseSubDistrictVC.swift
//  KarbalaIOS
//
//  Created by mac on 5/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreLocation
class ChooseSubDistrictVC: BaseVC {
    
    @IBOutlet weak var subDistrictsTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    
    internal let cellIdentifier = "RadioCell"
    internal let sectionIdentifier = "MarginSectionCell"
    var subDistricts:[SubDistrictModel]?
    var reportLocation:CLLocation!

    // weak var delegate:ChooseTownShipVcDelegate?
    var presenter:ChooseSubDistrictVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let subdistricts = self.subDistricts{
            presenter = ChooseSubDistrictVCPresenter(delegate: self, subdistricts: subdistricts)
        }
        self.changeImageTint()
        setupUI()
    }
    
    @IBAction func selectTownship(_ sender:UIButton){
        presenter.selectButtonPressed(selectedIndex: subDistrictsTableView.indexPathForSelectedRow?.section)
    }
    
}

//MARK:- Setup UI
extension ChooseSubDistrictVC{
    func setupUI(){
        setupTableView()
        selectButton.setTitle("Select".localized, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back".localized, style: .plain, target: nil, action: nil)
        if segue.identifier == AppConstants.AppSegues.fromSubdistrictsToAddReport.rawValue{
            let vc = segue.destination as! AddReportVC
            vc.selectedTowbship = sender as? SubDistrictModel
            vc.reportLocation = reportLocation
        }
    }
}


//MARK:- Radio Cell Delegate
extension ChooseSubDistrictVC:RadioCellDelegate{
    func didTapRadioButton(cell: RadioCell) {
        if let deselectedIndexPath = subDistrictsTableView.indexPathForSelectedRow{
            subDistrictsTableView.deselectRow(at: deselectedIndexPath, animated: true)
            subDistrictsTableView.cellForRow(at: deselectedIndexPath)?.isSelected = false
        }
        
        guard let indexPath = subDistrictsTableView.indexPath(for: cell) else{ return }
        subDistrictsTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        cell.isSelected = true
    }
}


