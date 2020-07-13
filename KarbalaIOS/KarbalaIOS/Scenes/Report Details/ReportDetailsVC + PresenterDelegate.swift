//
//  ReportDetailsVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
extension ReportDetailsVC:ReportDetailsVCPresenterDelegate{
    
    func didPlaySound(soundDuration: String) {
        changePlayButton(to: true)
        updateTimerAndProgressUI(currentProgress: 0, duration: soundDuration)
    }
    
    func didStillPlaying(progress: Float, time: String) {
        updateTimerAndProgressUI(currentProgress: progress, duration: time)
    }
    
    func didStopSound(progress: Float, stopTimeString: String) {
        changePlayButton(to: false)
        updateTimerAndProgressUI(currentProgress: progress, duration: stopTimeString)
    }
    
    func didEndPlaying(soundDuration: String) {
        changePlayButton(to: false)
        updateTimerAndProgressUI(currentProgress: 0, duration: soundDuration)
    }
    
    //MARK:- Populate Data
    func fetchingDataSuccess() {
        self.deleteBlankView(parentView: self.scrollView)
        presenter.populateData(cell: self)
    }
    
    func showImages() {
        self.reportImagesStackView.isHidden = false
        self.imagesCollectionView.reloadData()
    }
    
    func hideImages() {
        self.reportImagesStackView.isHidden = true
    }
    
    
    func showComment(comment: String,commentDate:String) {
        self.commentStackView.isHidden = false
        self.commentLabel.text = comment
        self.commentDateLabel.text = commentDate
    }
    
    
    func hideComment() {
        self.commentStackView.isHidden = true
    }
    
    func showVoiceView(duration: String) {
        self.voiceTimerLabel.text = duration
        self.voiceProgressView.setProgress(0, animated: false)
        reportVoiceStackView.isHidden = false
    }
    
    func hideVoiceView() {
        reportVoiceStackView.isHidden = true
    }
    
    func showLoader() {
        self.showLoaderIndictor(backgroundColor: UIColor.KarbalaBackgroundColor)
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func showError(message: String) {
        
    }
    
    func showError(error: ApiError) {
        self.addBlankView(errorType: error, parentView: self.scrollView,viewColor: UIColor.KarbalaBackgroundColor)
    }
    
    
}

extension ReportDetailsVC:ReportCellView{
    func displayReportType(reportType: String) {
        reportTypeLabel.text = reportType
    }
    
    func displayDesc(desc: String) {
        reportDescLabel.text = desc
        reportTitleLabel.text = desc
    }
    
    func displayDate(date: String) {
        reportDateLabel.text = date
    }
    
    
    func reportViewColor(colorHex: String?) {
        if let color = colorHex{
            reportStatusView.backgroundColor = UIColor.colorFromHexString(color)
            reportStatusView.alpha = 1
        }else{
            reportStatusView.alpha = 0
        }
    }
    
    func displayReportStatus(status: String, colorHex: String) {
        reportStatusLabel.text = status
        reportStatusLabel.textColor = UIColor.colorFromHexString(colorHex)
        
    }
    
}
