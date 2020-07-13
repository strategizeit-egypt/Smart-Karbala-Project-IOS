//
//  ChooseReportTypeVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ChooseReportTypeVCPresenterDelegate:LoaderDelegate {
    func fetchingDataSuccess()
    func didPressSelectButton(selected:ReportTypes)
}

class ChooseReportTypeVCPresenter{
    weak var delegate:ChooseReportTypeVCPresenterDelegate?
    private var reportTypes = [ReportTypes]()
   
    init(delegate:ChooseReportTypeVCPresenterDelegate,reportTypes:[ReportTypes]) {
        self.delegate = delegate
        self.reportTypes = reportTypes
        delegate.fetchingDataSuccess()
    }
    
//    func viewDidLoad(){
//       // getReportTypes()
//    }
    
    func getReportTypesCount()->Int{
        return reportTypes.count
    }
    
    func configure(cell:RadioCellView,for index:Int,isArabic:Bool){
        let reportType = self.reportTypes[index]
        if isArabic{
            cell.displayTitleAR(title: reportType.nameAR ?? "")
            cell.displayDescAR(desc: reportType.descriptionAR ?? "")
        }else{
            cell.displayTitle(title: reportType.name ?? "")
            cell.displayDesc(desc: reportType.descriptionEn ?? "")
        }
    }
        
    func selectButtonPressed(selectedIndex:Int?){
        guard let index = selectedIndex, reportTypes.count > index else{
            delegate?.showError(message: "choose_report_type_error_message".localized)
            return
        }
        delegate?.didPressSelectButton(selected: reportTypes[index])
    }
    
//    private func getReportTypes(){
//        guard let types = AppConstants.shared.appMetaData?.reportTypes else{
//            delegate?.showError(error: .notFound)
//            return
//        }
//        self.reportTypes = types
//    }
    
}
