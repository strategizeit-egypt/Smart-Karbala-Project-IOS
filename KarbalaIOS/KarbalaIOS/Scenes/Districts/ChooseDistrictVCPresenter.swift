//
//  ChooseTownShipVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ChooseDistrictVCPresenterDelegate:LoaderDelegate {
    func fetchingDataSuccess()
    func didPressSelectButton(selected:Municipalities)
}

protocol RadioCellView {
    func displayTitle(title:String)
    func displayTitleAR(title:String)
    func displayDesc(desc:String)
    func displayDescAR(desc:String)
}

class ChooseDistrictVCPresenter{
    private let townshipInteractor = NetworkService<[SubDistrictModel]>()
    weak var delegate:ChooseDistrictVCPresenterDelegate?
    private var districts = [Municipalities]()
   
    init(delegate:ChooseDistrictVCPresenterDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad(){
        //getTownShips()
        getDistricts()
    }
        
    func getDistrictsCount()->Int{
        return districts.count
    }
    
    func configure(cell:RadioCellView,for index:Int,isArabic:Bool){
        let township = self.districts[index]
        if isArabic{
            cell.displayTitleAR(title: township.nameAR ?? "")
            cell.displayDescAR(desc: township.nameAR ?? "")
        }else{
            cell.displayTitle(title: township.name ?? "")
            cell.displayDesc(desc: township.name ?? "")
        }
    }
        
    func selectButtonPressed(selectedIndex:Int?){
        guard let index = selectedIndex, districts.count > index else{
            delegate?.showError(message: "choose_district_error_message".localized)
            return
        }
        delegate?.didPressSelectButton(selected: districts[index])
    }
    
    private func getDistricts(){
           guard let districts = AppConstants.shared.appMetaData?.municipalities else{
               delegate?.showError(error: .notFound)
               return
           }
           self.districts = districts
           delegate?.fetchingDataSuccess()
       }
    
}

//MARK:- Network
extension ChooseDistrictVCPresenter{
//    private func getTownShips(){
//        delegate?.showLoader()
//        let request = MetaDataRoutes.getTownships
//        townshipInteractor.request(request: request, successCompletion: { [weak self](response) in
//            self?.delegate?.hideLoader()
//            guard let self = self else{return}
//            guard let result = response as? [SubDistrictModel] else{return}
//            if result.count > 0{
//                self.districts = result
//                self.delegate?.fetchingDataSuccess()
//            }else{
//                self.delegate?.showError(error: .notFound)
//            }
//        }) { [weak self](error) in
//            self?.delegate?.hideLoader()
//            guard let self = self else{return}
//            self.districts.removeAll()
//            self.delegate?.showError(error: error)
//        }
//    }
}
