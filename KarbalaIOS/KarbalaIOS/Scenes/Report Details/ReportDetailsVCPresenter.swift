//
//  ReportDetailsVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ReportDetailsVCPresenterDelegate:LoaderDelegate {
    
    func didPlaySound(soundDuration: String)
    func didStillPlaying(progress: Float, time: String)
    func didStopSound(progress: Float, stopTimeString: String)
    func didEndPlaying(soundDuration: String)
    
    func fetchingDataSuccess()
    
    func showImages()
    func hideImages()
    
    func showComment(comment:String,commentDate:String)
    func hideComment()
    
    func showVoiceView(duration:String)
    func hideVoiceView()
}

class ReportDetailsVCPresenter:NSObject{
    private let reportInteractor = NetworkService<ReportDetailsModel>()
    weak var delegate:ReportDetailsVCPresenterDelegate?
    private var SoundStopTimeInterval:TimeInterval?
    private var report:ReportDetailsModel?
    private var audioFileURL:URL?
    private var images = [ReportFileModel]()
    private var isArabic = false
    init(delegate:ReportDetailsVCPresenterDelegate) {
        super.init()
        self.delegate = delegate
        GlobalAudioPlayer.shared.delegate = self
    }
    
    func viewDidLoad(id:Int,isArabic:Bool){
        getReportDetails(reportTypeId: id)
        self.isArabic = isArabic
    }
    
    
    func didPressPlayButton(forPlaying:Bool){
        if forPlaying{
            guard let url = audioFileURL else{
                delegate?.didStopSound(progress: 0, stopTimeString: "00:00")
                return
            }
            GlobalAudioPlayer.shared.setupPlayer(playerURL: url, stopTime: SoundStopTimeInterval)
        }else{
            GlobalAudioPlayer.shared.stopPlayer()
        }
    }
    
    func getImagesCount()->Int{
        return images.count
    }
    
    func configureImageCell(for index:Int)->String{
        guard let imageName = images[index].filePath else{return ""}
        guard let reportID = report?.id else { return ""}
        return NetworkConstants.urls.file(reportID: reportID, fileName: imageName).value
    }
    
    func populateData(cell:ReportCellView){
        guard let report = self.report else {return}
        if let formatedDate = report.creationDate{
            cell.displayDate(date: Date.formateDateToString(firstFormat: AppConstants.serverReportCreationDate, secondFormat: AppConstants.reportCreationDate, dateString: formatedDate,splitChar: ".", toServer: false,isUTC: true))
        }
        cell.displayDesc(desc: report.details ?? "")
        cell.reportViewColor(colorHex: report.color)
        cell.displayReportType(reportType: isArabic ? report.reportTypeNameAR ?? "" : report.reportTypeName ?? "")
        cell.displayReportStatus(status: isArabic ? report.reportStatusNameAR ?? "" : report.reportStatusName ?? "", colorHex: report.color ?? "025FF0")
        
        self.setAudioFile()
        
        self.setImages()
        
        self.setComment()
        
    }
    
    private func setAudioFile(){
        
        if let audioPath = report?.reportFiles?.first(where: {
            $0.fileTypeID == AppConstants.FileTypes.audio.rawValue
        })?.filePath{
            guard let reportID = report?.id else { return }
            guard let url = URL(string: NetworkConstants.urls.file(reportID: reportID, fileName: audioPath).value) else {return}
            self.audioFileURL = url
            let duration = ((report?.duration ?? 0) / 1000).MinutesSecondsFromTimeInterval()
            delegate?.showVoiceView(duration: duration)
        }else{
            delegate?.hideVoiceView()
        }
    }
    
    private func setImages(){
        if let images = report?.reportFiles?.filter({
            $0.fileTypeID == AppConstants.FileTypes.image.rawValue
        }) , images.count > 0{
            self.images = images
            delegate?.showImages()
        }else{
            delegate?.hideImages()
        }
    }
    
    private func setComment(){
        guard let comments = report?.reportLogs , comments.count > 0 else{
            delegate?.hideComment()
            return
        }
        
        let formatedDate = comments.first?.creationDate ?? ""
        let date =  Date.formateDateToString(firstFormat: AppConstants.serverReportCreationDate, secondFormat: AppConstants.commentDate, dateString: formatedDate,splitChar: ".", toServer: false,isUTC: true)
        let comment = comments.first!.commentForUser ?? ""
        
        delegate?.showComment(comment:comment,commentDate: date )
        
    }
    
    func stopPlayerWhenNavigate(){
        GlobalAudioPlayer.shared.stopPlayer()
    }
    
    deinit {
        GlobalAudioPlayer.shared.removePlayer()
    }
    
}



//MARK:- Player
extension ReportDetailsVCPresenter:GlobalAudioPlayerDelegate{
    func didLoadPlayerTime(soundDuration: String) {
        delegate?.didPlaySound(soundDuration: soundDuration)
    }
    
    func didPlayerStillPlaying(progress: Float, time: String) {
        delegate?.didStillPlaying(progress: progress, time: time)
    }
    
    func didPressStop(currentTime: TimeInterval?, progress: Float, stopTimeString: String) {
        self.SoundStopTimeInterval = currentTime
        delegate?.didStopSound(progress: progress, stopTimeString: stopTimeString)
    }
    
    func playerDidEndPlaying(soundDuration: String) {
        self.SoundStopTimeInterval = nil
        delegate?.didEndPlaying(soundDuration: soundDuration)
    }
    
}

//MARK:- Network
extension ReportDetailsVCPresenter{
    private func getReportDetails(reportTypeId:Int){
        delegate?.showLoader()
        let request = ReportRoutes.getReportDetails(reportId: reportTypeId)
        reportInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            guard let report = response as? ReportDetailsModel else{return}
            self.report = report
            self.delegate?.fetchingDataSuccess()
        }) { [weak self](apiError) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            self.delegate?.showError(error: apiError)
        }
    }
}
