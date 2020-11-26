//
//  AddReportVC.swift
//  Amanaksa
//
//  Created by mac on 3/4/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreLocation
import BEMCheckBox
import UITextView_Placeholder
import YPImagePicker
import AVFoundation

class AddReportVC: BaseVC {
    
    @IBOutlet weak var addReportHeaderLabel: UILabel!
    @IBOutlet weak var addReportDescLabel: UILabel!
    
//    @IBOutlet weak var reportTypeTextField: DesignableUITextField!
    @IBOutlet weak var reportTypeLabel: UILabel!
    
    @IBOutlet weak var reportDescTextView: UITextView!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet weak var recordTimeLabel: UILabel!
    @IBOutlet weak var voiceView: UIView!
    @IBOutlet weak var deleteVoiceButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var soundProgressView: UIProgressView!
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var termsRadioBox: BEMCheckBox!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!

    
    var reportLocation:CLLocation!
    var cameraConfiguration:YPImagePickerConfiguration!
    var libraryConfiguration:YPImagePickerConfiguration!
    var picker:YPImagePicker!
   
    var imageBase64String = ""
    
    internal let cellIdentifier = "ImageCell"
    internal let sectionIdentifier = "MarginSectionCell"
    
    
    var selectedTowbship:SubDistrictModel?
    private var selectedReportType:ReportTypes?
    
    var presenter:AddReportVCPresenter!
    
    var photos:[UIImage] = []{
        didSet{
            photosCollectionView.isHidden = (photos.count == 0 ? true : false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeImageTint()
        setupUI()
        presenter = AddReportVCPresenter(delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent{
            print("Stop Recorder , Delete Audio File if found,stop player")
            presenter.deletePreviousVoice()
        }
    }
    
    //MARK:- Action For Record Audio
    @IBAction func recordVoice(_ sender: UIButton) {
        if sender.tag == 0{
            presenter.didPressRecordButton(forRecording: true)
        }else{
            presenter.didPressRecordButton(forRecording: false)
        }
    }
    
    
    //MARK:- Action For Play & Delete Audio
    @IBAction func play(_ sender: UIButton) {
        sender.isEnabled = false
        if sender.tag == 0{
            presenter.didPressPlayButton(forPlaying: true)
        }else{
            presenter.didPressPlayButton(forPlaying: false)
        }
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        presenter.deletePreviousVoice()
    }
    
    //MARK:- Action For Take Photo
    @IBAction func takePhotoFromCamera(_ sender: Any) {
        presenter.stopPlayerAndRecorder()
        picker = YPImagePicker(configuration: cameraConfiguration)
        uploadImageTabbed()
    }
    
    @IBAction func takePhotoFromLibrary(_ sender: Any) {
        presenter.stopPlayerAndRecorder()
        picker = YPImagePicker(configuration: libraryConfiguration)
        uploadImageTabbed()
    }
    
    @IBAction func sendReport(_ sender: UIButton) {
        submitReportToPresenter(showAlert: true)
    }
    
    func submitReportToPresenter(showAlert:Bool){
        var photosData = [Data]()
        for photo in photos{
            guard let data = photo.convertImageToData() else{
                continue
            }
            photosData.append(data)
        }
        
        presenter.validateData(details: reportDescTextView.text, reportTypeId: selectedReportType?.id, townshipId: selectedTowbship?.id, latitude: reportLocation.coordinate.latitude, longitude: reportLocation.coordinate.longitude, images: photosData, isAcceptTerms: termsRadioBox.on, showAlert: showAlert)

    }
    
}


//MARK:- UI Setup
extension AddReportVC{
    
    func setupUI(){
        localizeComponets()
        setTermsAndConditionsStyle()
        setupBemCheckBox()
        setupTextView()
        configureImagePicker()
        setupCollectionView()
//        setupTextFields()
        addActionToTermsLabel()
        setupProgressBar()
        playSoundButton.setImage(UIImage(named:  UIApplication.isRTL() ? "play-ar" : "play")!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.playSoundButton.tintColor = UIColor.buttonBackgroundColor
        deleteVoiceButton.setImage(UIImage(named: "close")!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.deleteVoiceButton.tintColor = UIColor.buttonBackgroundColor
    }
    
    func setupProgressBar(){
        soundProgressView.transform = soundProgressView.transform.scaledBy(x: 1, y: 2.5)
        soundProgressView.progressTintColor = UIColor.buttonBackgroundColor
    }
    
    func setupBemCheckBox(){
        termsRadioBox.delegate = self
        termsRadioBox.boxType = .square
    }
    
    func localizeComponets(){
        //reportTypeTextField.placeholder = "report_type".localized
        reportTypeLabel.text = "report_type".localized
        sendButton.setTitle("send_button".localized, for: .normal)
        addReportHeaderLabel.text = "complete_report".localized
        addReportDescLabel.text = "after_choose_location".localized
        reportDescTextView.placeholder = "report_details_hint".localized
        termsLabel.text = "terms_label".localized
    }
    
    
    func setTermsAndConditionsStyle(){
        let mainText = "terms_label".localized
        let subText = "Terms and conditions".localized
        let range = (mainText as NSString).range(of: subText)
        let attributedString = NSMutableAttributedString(string: mainText)
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.buttonBackgroundColor,NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,NSAttributedString.Key.underlineColor:UIColor.buttonBackgroundColor], range: range)
        DispatchQueue.main.async {
            self.termsLabel.attributedText = attributedString
        }
    }
    
    func configureImagePicker(){
        cameraConfiguration = YPImagePickerConfiguration()
        cameraConfiguration.onlySquareImagesFromCamera = true
        cameraConfiguration.usesFrontCamera = true
        cameraConfiguration.showsPhotoFilters = true
        cameraConfiguration.shouldSaveNewPicturesToAlbum = true
        cameraConfiguration.screens = [.library,.photo]
        
    }
    
    @objc func uploadImageTabbed(){
        
        if photos.count >= 5{
            self.showCustomAlert(messageTheme: .info, titleMessage: "", bodyMessage: "error_number_of_photos".localized, position: .top)
            return
        }
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.photos.append(photo.image)
                self.photosCollectionView.reloadData()
            }
            picker?.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func addActionToTermsLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToTerms))
        tapGesture.numberOfTapsRequired = 1
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(tapGesture)
    }
    
}



//MARK:- Bem Check Box Delegate
extension AddReportVC:BEMCheckBoxDelegate{
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.on{
            checkBox.on = false
            navigateToTerms()
        }
    }
}

//MARK:- Terms VC Delegate
extension AddReportVC:TermsVCDelegate{
    func didAcceptTerms() {
        termsRadioBox.on = true
    }
}



//MARK:- Image Cell Delagete
extension AddReportVC:ImageCellDelegate{
    func didTapDelete(for cell: ImageCell) {
        guard let indexPath = photosCollectionView.indexPath(for: cell) else{return}
        photosCollectionView.deleteItems(at: [indexPath])
        photos.remove(at: indexPath.item)
    }
}



//MARK:-Township & Report Type Delegates
extension AddReportVC:ChooseReportCategoryVcDelegate{
    
    func didSelectReportType(type: ReportTypes) {
        self.reportTypeLabel.text = UIApplication.isRTL() ? type.nameAR : type.name
        self.selectedReportType = type
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

//MARK:- stop and start sound configurtion and Update UI
extension AddReportVC{
    func changePlayButton(to isOn:Bool){
        playSoundButton.tag = isOn ? 1 : 0
        playSoundButton.setImage(UIImage(named: (isOn ? "pause" :  UIApplication.isRTL() ? "play-ar" : "play"))!.withRenderingMode(.alwaysTemplate), for: .normal)
        self.playSoundButton.tintColor = UIColor.buttonBackgroundColor

        if isOn{
            animatePlayButton()
        }else{
            animateStopButton()
        }
    }
    
    func updateTimerAndProgressUI(currentProgress:Float,duration:String){
        DispatchQueue.main.async {
            self.soundProgressView.setProgress(currentProgress, animated: false)
            self.timerLabel.text = duration
        }
    }
}


//MARK:- play button Animation
extension AddReportVC{
    func animatePlayButton(){
        UIView.animate(withDuration: 0.2) {
            self.playSoundButton.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
            self.playSoundButton.isEnabled = true
        }
    }
    
    func animateStopButton(){
        UIView.animate(withDuration: 0.2) {
            self.playSoundButton.transform = .identity
            self.playSoundButton.isEnabled = true
        }
    }
}
