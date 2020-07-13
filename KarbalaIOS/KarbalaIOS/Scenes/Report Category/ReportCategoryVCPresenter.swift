//
//  ReportCategoryVCPresenter.swift
//  KarbalaIOS
//
//  Created by mac on 5/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ChooseReportCategoryVCPresenterDelegate:LoaderDelegate {
    func fetchingDataSuccess()
    func didPressSelectButton(selected:ReportTypeCategories)
}


class ChooseReportCategoryVCPresenter{
    weak var delegate:ChooseReportCategoryVCPresenterDelegate?
    private var reportCategories = [ReportTypeCategories]()
   
    init(delegate:ChooseReportCategoryVCPresenterDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad(){
        getReportTypes()
    }
    
    func getReportCategoriesCount()->Int{
        return reportCategories.count
    }
    
    func configure(cell:MoreView,for index:Int,isArabic:Bool){
        let reportCategory = self.reportCategories[index]
        cell.displayItemImage(imageName: reportCategory.image ?? "", isUrl: true)
        if isArabic{
            cell.displayItemNameInAR(name: reportCategory.nameAR ?? "")
        }else{
            cell.displayItemName(name: reportCategory.name ?? "")
        }
    }
    
    func getItem(for index:Int,isArabic:Bool)->String{
        let reportCategory = self.reportCategories[index]
        return isArabic ? reportCategory.nameAR ?? "" : reportCategory.name ?? ""
    }
        
    func selectButtonPressed(selectedIndex:Int?){
        guard let index = selectedIndex, reportCategories.count > index else{
            delegate?.showError(message: "choose_report_type_error_message".localized)
            return
        }
        delegate?.didPressSelectButton(selected: reportCategories[index])
    }
    
    private func getReportTypes(){
        guard let types = AppConstants.shared.appMetaData?.reportTypeCategories else{
            delegate?.showError(error: .notFound)
            return
        }
        self.reportCategories = types
        delegate?.fetchingDataSuccess()
    }
    
}
