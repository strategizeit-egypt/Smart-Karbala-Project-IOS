//
//  ChooseSubDistrictVCPresenter.swift
//  KarbalaIOS
//
//  Created by mac on 5/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ChooseSubDistrictVCPresenterDelegate:LoaderDelegate {
    func fetchingDataSuccess()
    func didPressSelectButton(selected:SubDistrictModel)
}

class ChooseSubDistrictVCPresenter{
    weak var delegate:ChooseSubDistrictVCPresenterDelegate?
    private var subDistricts = [SubDistrictModel]()
   
    init(delegate:ChooseSubDistrictVCPresenterDelegate,subdistricts:[SubDistrictModel]) {
        self.delegate = delegate
        self.subDistricts = subdistricts
        delegate.fetchingDataSuccess()
    }
        
    func getSubDistrictsCount()->Int{
        return subDistricts.count
    }
    
    func configure(cell:RadioCellView,for index:Int,isArabic:Bool){
        let township = self.subDistricts[index]
        if isArabic{
            cell.displayTitleAR(title: township.nameAR ?? "")
            cell.displayDescAR(desc: township.descriptionAR ?? "")
        }else{
            cell.displayTitle(title: township.name ?? "")
            cell.displayDesc(desc: township.descriptionEn ?? "")
        }
    }
        
    func selectButtonPressed(selectedIndex:Int?){
        guard let index = selectedIndex, subDistricts.count > index else{
            delegate?.showError(message: "choose_district_error_message".localized)
            return
        }
        delegate?.didPressSelectButton(selected: subDistricts[index])
    }
    
    
}
