//
//  ChooseTownShipVC.swift
//  Amanaksa
//
//  Created by mac on 3/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreLocation
//TODO:-
// Check if description is more than 2 rows
// Make delegate to return selected township

//protocol ChooseTownShipVcDelegate:NSObjectProtocol {
//    func didSelectTownship(township:TownshipModel)
//}

class ChooseDistrictVC: BaseVC {
    
    @IBOutlet weak var districtsTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    
    internal let cellIdentifier = "RadioCell"
    internal let sectionIdentifier = "MarginSectionCell"
   
   // weak var delegate:ChooseTownShipVcDelegate?
    var presenter:ChooseDistrictVCPresenter!
    var reportLocation:CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeImageTint()
        setupUI()
        presenter = ChooseDistrictVCPresenter(delegate: self)
        presenter.viewDidLoad()
    }
    
    @IBAction func selectTownship(_ sender:UIButton){
        presenter.selectButtonPressed(selectedIndex: districtsTableView.indexPathForSelectedRow?.section)
    }
    
}

//MARK:- Setup UI
extension ChooseDistrictVC{
    func setupUI(){
        setupTableView()
        selectButton.setTitle("Select".localized, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.AppSegues.fromTownshipsToAddReport.rawValue{
            let vc = segue.destination as! AddReportVC
            vc.selectedTowbship = sender as? SubDistrictModel
            vc.reportLocation = reportLocation
        }else if segue.identifier == AppConstants.AppSegues.fromTownshipsToSubdistricts.rawValue{
            let vc = segue.destination as! ChooseSubDistrictVC
            vc.subDistricts = sender as? [SubDistrictModel]
            vc.reportLocation = reportLocation
        }
    }
}


//MARK:- Radio Cell Delegate
extension ChooseDistrictVC:RadioCellDelegate{
    func didTapRadioButton(cell: RadioCell) {
        if let deselectedIndexPath = districtsTableView.indexPathForSelectedRow{
            districtsTableView.deselectRow(at: deselectedIndexPath, animated: true)
            districtsTableView.cellForRow(at: deselectedIndexPath)?.isSelected = false
        }
        
        guard let indexPath = districtsTableView.indexPath(for: cell) else{ return }
        districtsTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        cell.isSelected = true
    }
}


