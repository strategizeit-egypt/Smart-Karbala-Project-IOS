//
//  MapVC.swift
//  Amanaksa
//
//  Created by mac on 2/23/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
import MapKit
class MapVC: UIViewController {
    
    @IBOutlet weak var addReportButton: UIButton!
    @IBOutlet weak var addReportHintLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var shadowView: UIView!
    
    private let locationManager = CLLocationManager()
    private var userLocation:CLLocation?
    private let zoomLevel:Float = 19
    
    private let karbalaLocation = CLLocation(latitude: 32.61603, longitude: 44.02488)
    
    let polygon = MKPolygon(coordinates: &AppConstants.shared.locations, count: AppConstants.shared.locations.count)
    var polygonRenderer:MKPolygonRenderer?
    
    var isBackFromConfirmation = false
    var isComeFromAutoComplete:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        changeTabBarColors()
        polygonRenderer = MKPolygonRenderer(polygon: polygon)
        
        
//        let path = GMSMutablePath()
//        for location in AppConstants.shared.locations{
//            path.add(location)
//        }
//            let polyline = GMSPolyline(path: path)
//            polyline.strokeColor = .blue
//            polyline.strokeWidth = 5.0
//            polyline.map = mapView
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if isBackFromConfirmation{
            isBackFromConfirmation = false
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        locationManager.stopUpdatingLocation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let path = UIBezierPath(roundedRect:  CGRect(x: 0, y: 0, width: view.frame.width, height: (self.tabBarController?.tabBar.frame.height)!), byRoundingCorners: [.topRight,.topLeft], cornerRadii: CGSize(width: 40, height: 40))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.tabBarController?.tabBar.layer.mask = mask
    }
    
    func changeTabBarColors(){
        let font = UIFont().regularFont(with: 15)
        let selectedTextColor = UIColor.black
        let unselectedTextColor = UIColor.clear
        for (index,item) in (self.tabBarController?.tabBar.items?.enumerated())! {
            if index == 0{
                item.title = "title_new_complaint".localized
            }else if index == 1{
                item.title = "title_complaints".localized
            }else{
                item.title = "More".localized
            }
            
            
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedTextColor, NSAttributedString.Key.font:font], for: .selected)
            
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedTextColor, NSAttributedString.Key.font:font], for: .normal)
        }
    }
    
    
    @IBAction func addReport(_ sender: UIButton) {
        if userLocation == nil{
            self.showCustomAlert(bodyMessage: "location_is_empty".localized)
        }else if checkIfLocationInKarbala() == false{
            self.showCustomAlert(bodyMessage: "location_not_in_karbala".localized)
        }else{
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromMapToTownships.rawValue, sender: userLocation)
        }
    }
    
    
    func checkIfLocationInKarbala()->Bool{
        let mapPoint: MKMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude))
        let polygonViewPoint: CGPoint = polygonRenderer!.point(for: mapPoint)
        if polygonRenderer!.path.contains(polygonViewPoint) {
           return true
        }
        return false
    }
    
    @IBAction func selectCurrentLocation(_ sender: UIButton) {
        checkLocationAuthorizationStatus()
    }
    
    
}

//MARK:- UI Setup
extension MapVC{
    func setupUI(){
        localizeComponets()
        setUpGoogleMaps()
        setupSearchTextField()
        checkLocationAuthorizationStatus()
        setShadowView()
    }
    
    func setShadowView(){
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.colorFromHexString("707070").withAlphaComponent(0.3).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.locations = [0.05,0.65,1]
        
        gradient.frame = self.shadowView.bounds
        self.shadowView.layer.insertSublayer(gradient, at: 0)
    }
    
    func localizeComponets(){
        addReportButton.setTitle("add_report_button".localized, for: .normal)
        addReportHintLabel.text = "add_report_hint".localized
        searchTextField.placeholder = "search_placholder".localized
    }
    
    func setupSearchTextField(){
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(autocompleteClicked), for: .editingDidBegin)
    }
    
    @objc func autocompleteClicked(){
        searchTextField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        acController.primaryTextColor = UIColor.black
        acController.secondaryTextColor = UIColor.buttonBackgroundColor
        present(acController, animated: true, completion: nil)
    }
    
    func setUpGoogleMaps(){
        mapView.delegate = self
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false
    }
}

//MARK:- Location Manager Utilis
extension MapVC{
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .restricted, .denied:
                userLocation = nil
                self.showDefaultAlert(firstButtonTitle: "Settings".localized, secondButtonTitle: "cancel".localized, title: "Alert".localized, message: "location_is_denied".localized) { (openSettings) in
                    if openSettings{
                        Helper.openSettings()
                    }else{
                        self.setCamera(location: self.karbalaLocation, zoom: self.zoomLevel)
                    }
                }
            case  .authorizedWhenInUse,.notDetermined,.authorizedAlways:
                initalizeLocationManager()
            default:break
            }
        }else{
            self.showDefaultAlert(firstButtonTitle: "Settings".localized, secondButtonTitle: "cancel".localized, title: "Alert".localized, message: "location_is_off".localized) { (openSettings) in
                if openSettings{
                    Helper.openSettings()
                }else{
                    self.setCamera(location: self.karbalaLocation, zoom: self.zoomLevel)
                }
            }
        }
    }
    
    
    
    func initalizeLocationManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setCamera(location:CLLocation , zoom:Float){
        let camera = GMSCameraPosition.camera(withLatitude:  location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoom)
        DispatchQueue.main.async {
            self.mapView.animate(to: camera)
        }
    }
}

//MARK:- Location Manager Delegate
extension MapVC:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        self.userLocation = location
        self.setCamera(location: location, zoom: zoomLevel)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        userLocation = nil
    }
}

//MARK:- Map View Delegate
extension MapVC:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if !isComeFromAutoComplete{
            let point = mapView.center
            let coordinate = mapView.projection.coordinate(for: point)
            self.userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            //mapView.animate(to: position)
        }
        isComeFromAutoComplete = false
    }
    
    
}

//MARK:- Google Places View Delegate
extension MapVC:GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        searchTextField.text = place.name
        let location = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        print("Auto:\(location.coordinate)")
        self.isComeFromAutoComplete = true
        self.userLocation = location
        self.setCamera(location: location, zoom: self.zoomLevel)
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

//MARK:- Text Field Delegate
extension MapVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}


//MARK:- Handle Segues
extension MapVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Districts".localized, style: .plain, target: nil, action: nil)
        if segue.identifier == AppConstants.AppSegues.fromMapToTownships.rawValue{
            let vc = segue.destination as! ChooseDistrictVC
            vc.reportLocation = sender as? CLLocation
        }
    }
}

