//
//  MyReportsVCPresenter.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol MyReportsVCPresenterDelegate:LoaderDelegate {
    func navigateToDetailsScreen(with id: Int)
    func fetchingDataSuccess()
}

protocol ReportCellView{
    func displayReportType(reportType:String)
    func displayDesc(desc:String)
    func displayDate(date:String)
    func reportViewColor(colorHex:String?)
    func displayReportStatus(status:String,colorHex:String)
}

class MyReportsVCPresenter{
    private let reportsInteractor = NetworkService<[ReportDetailsModel]>()
    weak var delegate:MyReportsVCPresenterDelegate?
    private var page:Int = 0
    private var pageSize:Int = 0
    private var reports = [ReportDetailsModel]()
    private var sort:Bool = false{
        didSet{
            self.getReports()
        }
    }
    private var word:String = ""{
        didSet{
            self.getReports()
        }
    }
    init(delegate:MyReportsVCPresenterDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad(){
        self.getReports()
    }
    
    func changeSearchName(word:String){
        self.word = word
    }
    
    func changeFilter(){
        self.sort.toggle()
    }
    
    private func getReports(){
        self.resetParamters()
        self.getMyReports(withPage: self.page)
    }
    
    func loadMore(for index:Int){
        if index == pageSize - 1{
            self.getMyReports(withPage: self.page + 1)
        }
    }
    
    func getReportsCount()->Int{
        return reports.count
    }
    
    func configure(cell:ReportCellView,for index:Int,isArabic:Bool){
        let report = self.reports[index]
        if let formatedDate = report.creationDate{
            cell.displayDate(date: Date.formateDateToString(firstFormat: AppConstants.serverReportCreationDate, secondFormat: AppConstants.reportCreationDate, dateString: formatedDate,splitChar: ".", toServer: false,isUTC: true))
        }
        cell.displayDesc(desc: report.details ?? "")
        cell.reportViewColor(colorHex: report.color )
        cell.displayReportType(reportType: isArabic ? report.reportTypeNameAR ?? "" : report.reportTypeName ?? "")
        cell.displayReportStatus(status: isArabic ? report.reportStatusNameAR ?? "" : report.reportStatusName ?? "", colorHex: report.color ?? "025FF0")
    }
    
    func selectRow(for index:Int){
        guard let reportID = reports[index].id else{
            return
        }
        delegate?.navigateToDetailsScreen(with: reportID)
    }
    
    private func resetParamters(){
        self.reports.removeAll()
        self.page = 0
        self.pageSize = 0
    }
    
}

//MARK:- Network
extension MyReportsVCPresenter{
    private func getMyReports(withPage:Int){
        delegate?.showLoader()
        let request = ReportRoutes.searchInReports(word: word, page: withPage, sorting: sort)
        print(request.urlRquest)
        reportsInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            guard let result = response as? [ReportDetailsModel] else{return}
            if self.page == 0{
                self.reports = result
            }else{
                self.reports.append(contentsOf: result)
            }
            self.delegate?.fetchingDataSuccess()
            self.page += 1
            self.pageSize += 30
        }) { [weak self](error) in
           self?.delegate?.hideLoader()
           guard let self = self else{return}
            self.reports.removeAll()
            self.delegate?.showError(error: error)
        }
    }
    
}
