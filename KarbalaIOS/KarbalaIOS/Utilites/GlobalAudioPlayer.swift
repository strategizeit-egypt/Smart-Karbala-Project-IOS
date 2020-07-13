//
//  GlobalAudioPlayer.swift
//  Together IOS
//
//  Created by mac on 2/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import AVFoundation


protocol  GlobalAudioPlayerDelegate:NSObjectProtocol {
    func didLoadPlayerTime(soundDuration:String)
    func didPlayerStillPlaying(progress:Float,time:String)
    func didPressStop(currentTime:TimeInterval?,progress:Float,stopTimeString:String)
    func playerDidEndPlaying(soundDuration:String)
}

class GlobalAudioPlayer:NSObject{
    
    static let shared = GlobalAudioPlayer()
    
    private var player:AVPlayer?
    
    private var playTimer:Timer = Timer()
    
    weak var delegate:GlobalAudioPlayerDelegate?
    
    private override init() {
        super.init()
    }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //MARK:- Set audio url
    // Play sound from stop time
    func setupPlayer(playerURL:URL,stopTime:TimeInterval?,setPlayerOnly:Bool = false){
        do{
            stopTimer()
            
            let playerItem:AVPlayerItem = AVPlayerItem(url: playerURL)
            player = AVPlayer(playerItem: playerItem)
            if setPlayerOnly {return}
            if stopTime != nil{
                let time = CMTime(seconds: stopTime!, preferredTimescale: 1000000)
                player?.currentItem?.seek(to: time)
                delegate?.didLoadPlayerTime(soundDuration: time.seconds.MinutesSecondsFromTimeInterval() )
            }else{
                delegate?.didLoadPlayerTime(soundDuration: player?.currentItem?.asset.duration.seconds.MinutesSecondsFromTimeInterval() ?? "")
            }
            self.addEndOfPlayerObserver()
            player!.automaticallyWaitsToMinimizeStalling = false
            player!.play()
            startTimer()
            
        }catch let error{
            print(error.localizedDescription)
            
        }
        
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //MARK:- audio player observer
    private func addEndOfPlayerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private func removeObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        self.playerIsEndPlaying()
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //MARK:- Timer
    private func startTimer(){
        playTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            self?.updateTimer()
        })
    }
    
    private func stopTimer(){
        playTimer.invalidate()
    }
    
    @objc private func updateTimer() {
        let progressTuple = getProgressValueAndProgressTime()
        delegate?.didPlayerStillPlaying(progress: progressTuple.progressValue, time: progressTuple.progressTimeString)
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //MARK:- Stop Or end audio player
    // User stop audio player or audio player is ended
    func stopPlayer(){
        let time = handleStopOrEndOfPlayer()
        let progressTuple = getProgressValueAndProgressTime()
        delegate?.didPressStop(currentTime: time?.seconds, progress: progressTuple.progressValue, stopTimeString: progressTuple.progressTimeString)
    }
    
    func playerIsEndPlaying(){
        let _ = handleStopOrEndOfPlayer()
        delegate?.playerDidEndPlaying( soundDuration: getSoundPlayerDuration())
    }
    
    func stopPlayerIfPlaying(){
        if player != nil{
            GlobalAudioPlayer.shared.stopPlayer()
        }
    }
    
}

//MARK:- Utilites
extension GlobalAudioPlayer{
    private func getSoundPlayerDuration()->String{
        if let duration = self.player?.currentItem?.asset.duration.seconds{
            return Float(duration).fromatSecondsFromTimer()
        }

        return "00:00"
    }
    
    func getDurationInMillSeconds()->Int{
        if  let duration = self.player?.currentItem?.asset.duration.seconds{
            return Int(duration * 1000)
        }
        return 0
    }
    
    private func handleStopOrEndOfPlayer()->CMTime?{
        self.stopTimer()
        let currentTime = player?.currentItem?.asset.duration.seconds == player?.currentItem?.currentTime().seconds ? nil : player?.currentTime()
        player?.pause()
        player?.currentItem?.seek(to: currentTime == nil ? .zero : currentTime!, completionHandler: nil)
        self.removeObserver()
        return currentTime
    }
    
    func getProgressValueAndProgressTime()->(progressValue:Float,progressTimeString:String){
        if let currentTime = player?.currentItem?.currentTime().seconds , let duration = player?.currentItem?.asset.duration.seconds{
            return ( Float(currentTime/duration) , currentTime.MinutesSecondsFromTimeInterval())
        }
        return (0,"")
    }
    
    func removePlayer(){
        let _ = handleStopOrEndOfPlayer()
        player = nil
    }
    
    
}

