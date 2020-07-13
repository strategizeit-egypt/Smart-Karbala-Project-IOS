//
//  AddReportVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import AVFoundation

protocol AddReportVCPresenterDelegate:LoaderDelegate {
    func navigateToTermsScreen()
    func navigateToConfirmationPage()
    func showConfirmationAlert()
    
    func didPlaySound(soundDuration: String)
    func didStillPlaying(progress: Float, time: String)
    func didStopSound(progress: Float, stopTimeString: String)
    func didEndPlaying(soundDuration: String)
    func showErrorWithDefaultAlert(message:String)
    
    func didStillRecording(currentRecordingTime:String)
    func didStopRecording(recordingTime:String)
    func didDeleteRecordingAudio()
}

class AddReportVCPresenter:NSObject{
    private let reportInteractor = NetworkService<ReportDetailsModel>()
    weak var delegate:AddReportVCPresenterDelegate?
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder?
    private var recordTimer:Timer = Timer()
    private var SoundStopTimeInterval:TimeInterval?
    
    
    init(delegate:AddReportVCPresenterDelegate) {
        super.init()
        self.delegate = delegate
        GlobalAudioPlayer.shared.delegate = self
    }
    
    func validateData(details:String?,reportTypeId:Int?,townshipId:Int?,latitude:Double
        ,longitude:Double,images:[Data]?,isAcceptTerms:Bool,showAlert:Bool){
        
        guard let townshipId = townshipId else{
            delegate?.showError(message: "choose_township_error_message".localized)
            return
        }
        
        guard let reportTypeId = reportTypeId else{
            delegate?.showError(message: "report_type_error_message".localized)
            return
        }
        
        guard let reportDetails = details  else{
            delegate?.showError(message: "report_details_error_message".localized)
            return
        }
        
//        guard let images = images , images.count > 0 else{
//            delegate?.showError(message: "choose_report_image_error_message".localized)
//            return
//        }
        
        if let isRecording = audioRecorder?.isRecording , isRecording == true{
            delegate?.showError(message: "stop_recording_message".localized)
            return
        }
        
        if getAudioFileData() == nil && reportDetails.isStringEmpty(){
            delegate?.showError(message: "complaint_details_audio_error_message".localized)
            return
        }
        
//        if isAcceptTerms == false{
//            delegate?.navigateToTermsScreen()
//            return
//        }
        
        if showAlert{
            delegate?.showConfirmationAlert()
        }else{
            self.addReport(details: reportDetails, reportTypeId: "\(reportTypeId)", townshipId: "\(townshipId)", latitude: "\(latitude)", longitude: "\(longitude)", images: images, audioFile: getAudioFileData(), duration: getDuartion())
        }
        
    }
    
    private func getAudioFileData()->Data?{
        guard let url = audioRecorder?.url else{return nil}
        return try? Data(contentsOf: url)
    }
    
    private func getDuartion()->String{
        print(GlobalAudioPlayer.shared.getDurationInMillSeconds())
        return "\(GlobalAudioPlayer.shared.getDurationInMillSeconds())"
    }
    
    func didPressRecordButton(forRecording:Bool){
        if forRecording{
            self.setupRecorderSession()
        }else{
            self.stopRecording()
        }
    }
    
    func didPressPlayButton(forPlaying:Bool){
        if forPlaying{
            guard let audioRecorder = audioRecorder else{
                delegate?.didStopSound(progress: 0, stopTimeString: "00:00")
                return
            }
            GlobalAudioPlayer.shared.setupPlayer(playerURL: audioRecorder.url, stopTime: SoundStopTimeInterval)
        }else{
            GlobalAudioPlayer.shared.stopPlayer()
        }
    }
    
    func stopPlayerAndRecorder(){
        if let isRecording = audioRecorder?.isRecording , isRecording == true{
           stopRecording()
        }
        GlobalAudioPlayer.shared.stopPlayerIfPlaying()
    }
    
}

extension AddReportVCPresenter{
    private func setupRecorderSession(){
        
        self.deletePreviousVoice()

        recordingSession = AVAudioSession.sharedInstance()
        do {
            try self.recordingSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try recordingSession.setActive(true)
            if recordingSession.recordPermission == .denied || recordingSession.recordPermission == .undetermined{
                requestPermission { [weak self](isAllowed) in
                    if isAllowed{
                        self?.startRecording()
                    }else{
                        self?.delegate?.showErrorWithDefaultAlert(message: "record_audio_denied".localized)
                    }
                }
            }else{
                self.startRecording()
            }
        } catch {
            delegate?.showErrorWithDefaultAlert(message: "record_audio_denied".localized)
        }
    }
    
    private func requestPermission(completion:@escaping (_ isAllowed:Bool)->()){
        recordingSession.requestRecordPermission() { allowed in
            if allowed {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}

//MARK:- Start Recording
extension AddReportVCPresenter{
    private func startRecording() {
        let audioFilename = Helper.getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            startTimer()
        } catch {
            print("Failed to record")
        }
    }
    
    func startTimer(){
        recordTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.delegate?.didStillRecording(currentRecordingTime: self.getRecordTimeInString())
        })
    }
    
    private func getRecordTimeInString()->String{
        return self.audioRecorder?.currentTime.MinutesSecondsFromTimeInterval() ?? "00:00"
    }
    
}

//MARK:- Stop Recording
extension AddReportVCPresenter{
    private func stopRecording(){
        audioRecorder?.stop()
        recordTimer.invalidate()
        guard let audioRecorder = audioRecorder else{
            delegate?.didStopSound(progress: 0, stopTimeString: "00:00")
            return
        }
        GlobalAudioPlayer.shared.setupPlayer(playerURL: audioRecorder.url, stopTime: nil,setPlayerOnly: true)
        delegate?.didStopRecording(recordingTime: getRecordTimeInString())
    }
}

//MARK:- Delete Recorder
extension AddReportVCPresenter{
    func deletePreviousVoice(){
        DispatchQueue.global(qos: .userInteractive).async {
            GlobalAudioPlayer.shared.removePlayer()
        }
        if audioRecorder != nil{
            if let isRecording = audioRecorder?.isRecording , isRecording == true{
                audioRecorder?.stop()
            }
            if let isDeleted = audioRecorder?.deleteRecording() , isDeleted == true{
                delegate?.didDeleteRecordingAudio()
            }
        }
    }
}

//MARK:- Player
extension AddReportVCPresenter:GlobalAudioPlayerDelegate{
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
extension AddReportVCPresenter{
    private func addReport(details:String?,reportTypeId:String,townshipId:String,latitude:String
        ,longitude:String,images:[Data]?,audioFile:Data?,duration:String){
        delegate?.showLoader()
        let request = ReportRoutes.addReport(title: "", details: details, reportTypeId: reportTypeId, townshipId: townshipId, latitude: latitude, longitude: longitude, duration: duration)
        reportInteractor.UploadFile(request: request, requestParameters: request.parameters as! [String : String], audioFile: audioFile, imagesFiles: images, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            guard let report = response as? ReportDetailsModel else{return}
            self.delegate?.navigateToConfirmationPage()
        }) { [weak self](apiError) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            self.delegate?.showError(message: apiError.localizedDescription)
        }
    }
}
