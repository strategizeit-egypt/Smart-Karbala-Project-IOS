//
//  ReportDetailsVC.swift
//  Amanaksa
//
//  Created by mac on 2/24/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ReportDetailsVC: BaseVC {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    internal let cellIdentifier = "ImageCell"
    internal let sectionIdentifier = "MarginSectionCell"
    
    @IBOutlet weak var reportImagesStackView: UIStackView!
    @IBOutlet weak var reportImagesLabel: UILabel!
    
    @IBOutlet weak var reportVoiceStackView: UIStackView!
    @IBOutlet weak var reportVoiceLabel: UILabel!
    
    @IBOutlet weak var reportTypeLabel: UILabel!
    @IBOutlet weak var reportTitleLabel: UILabel!
    @IBOutlet weak var reportDateLabel: UILabel!
    @IBOutlet weak var reportStatusLabel: UILabel!
    @IBOutlet weak var reportStatusView: UIView!
    @IBOutlet weak var reportDescLabel: UILabel!
    
    @IBOutlet weak var playVoiceButton: UIButton!
    @IBOutlet weak var voiceTimerLabel: UILabel!
    @IBOutlet weak var voiceProgressView: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var commentStackView: UIStackView!
    @IBOutlet weak var commentTitleLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    private var SoundStopTimeInterval:TimeInterval?
    
    var reportId:Int?
    
    var presenter:ReportDetailsVCPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = ReportDetailsVCPresenter(delegate:self)
        if let reportId = reportId{
            presenter.viewDidLoad(id: reportId, isArabic: UIApplication.isRTL())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent{
            print("stop player")
            GlobalAudioPlayer.shared.removePlayer()
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        presenter.didPressPlayButton(forPlaying: sender.tag == 0 ? true : false)
    }
    
}

//MARK:- Setup UI
extension ReportDetailsVC{
    func setupUI(){
        setupCollectionView()
        localizeComponets()
        setupProgressBar()
        addRefresherToScrollView()
        playVoiceButton.setImage(UIImage(named:  UIApplication.isRTL() ? "play-ar" : "play")!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.playVoiceButton.tintColor = UIColor.buttonBackgroundColor
    }
    
    func addRefresherToScrollView(){
        scrollView.addRefresherToScrollView()
        scrollView.refreshControl?.addTarget(self, action: #selector(refreshDetails), for: .valueChanged)
    }
    
    @objc func refreshDetails(){
        if let reportId = reportId{
            presenter.viewDidLoad(id: reportId, isArabic: UIApplication.isRTL())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    func setupProgressBar(){
        voiceProgressView.transform = voiceProgressView.transform.scaledBy(x: 1, y: 2.5)
        voiceProgressView.progressTintColor = UIColor.buttonBackgroundColor
    }
    
    
    
    func localizeComponets(){
        reportImagesLabel.text = "report_images_header".localized
        reportVoiceLabel.text = "report_voice_header".localized
        commentTitleLabel.text = "Comment".localized
    }
    
}


//MARK:- play button Animation
extension ReportDetailsVC{
    func animatePlayButton(){
        UIView.animate(withDuration: 0.2) {
            self.playVoiceButton.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
            self.playVoiceButton.isEnabled = true
        }
    }
    
    func animateStopButton(){
        UIView.animate(withDuration: 0.2) {
            self.playVoiceButton.transform = .identity
            self.playVoiceButton.isEnabled = true
        }
    }
}


//MARK:- stop and start sound configurtion and Update UI
extension ReportDetailsVC{
    func changePlayButton(to isOn:Bool){
        playVoiceButton.tag = isOn ? 1 : 0
        playVoiceButton.setImage(UIImage(named: (isOn ? "pause" :  UIApplication.isRTL() ? "play-ar" : "play"))!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.playVoiceButton.tintColor = UIColor.buttonBackgroundColor
        if isOn{
            animatePlayButton()
        }else{
            animateStopButton()
        }
    }
    
    func updateTimerAndProgressUI(currentProgress:Float,duration:String){
        DispatchQueue.main.async {
            self.voiceProgressView.setProgress(currentProgress, animated: true)
            self.voiceTimerLabel.text = duration
        }
    }
}



