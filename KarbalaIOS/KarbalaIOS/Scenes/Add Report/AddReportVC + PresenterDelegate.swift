//
//  AddReportVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
extension AddReportVC:AddReportVCPresenterDelegate{
    
    func showConfirmationAlert() {
        self.showDefaultAlert(title: "", message: "sure_send_report".localized) { (send) in
            if send{
                self.submitReportToPresenter(showAlert: false)
            }
        }
    }
    
    func navigateToConfirmationPage() {
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromAddReportToConfirmation.rawValue, sender: nil)
    }
    
    func navigateToTermsScreen() {
        navigateToTerms()
    }
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func showError(error: ApiError) {
        
    }
    
    func showErrorWithDefaultAlert(message: String) {
        Helper.showSettingsAlert(message: message, viewController: self)
//        self.showDefaultAlert(title: "Error".localized, message: message)
    }
    
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
    
    
    func didStillRecording(currentRecordingTime: String) {
        recordButton.tag = 1
        self.recordTimeLabel.isHidden = false
        self.voiceView.isHidden = true
        self.recordTimeLabel.text = currentRecordingTime
        self.timerLabel.text = "00:00"
    }
    
    func didStopRecording(recordingTime: String) {
        recordButton.tag = 0
        self.recordTimeLabel.isHidden = true
        self.voiceView.isHidden = false
        self.timerLabel.text = recordTimeLabel.text
        self.recordTimeLabel.text = "00:00"
        soundProgressView.setProgress(0, animated: false)
        self.playSoundButton.setImage(UIImage(named:  UIApplication.isRTL() ? "play-ar" : "play")!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.playSoundButton.tintColor = UIColor.buttonBackgroundColor
        playSoundButton.transform = .identity
    }
    
    func didDeleteRecordingAudio() {
        DispatchQueue.main.async {
            self.playSoundButton.tag = 0
            self.voiceView.isHidden = true
            self.timerLabel.text = "00:00"
            self.soundProgressView.setProgress(0, animated: false)
            self.playSoundButton.setImage(UIImage(named:  UIApplication.isRTL() ? "play-ar" : "play")!.withRenderingMode(.alwaysTemplate), for: .normal)
            self.playSoundButton.tintColor = UIColor.buttonBackgroundColor

            self.playSoundButton.transform = .identity
            
           
        }
    }
    
}
