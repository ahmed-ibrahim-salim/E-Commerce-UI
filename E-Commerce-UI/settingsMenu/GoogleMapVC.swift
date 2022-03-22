//
//  GoogleMapVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/31/22.
//

import UIKit
import CoreLocation
import GoogleMaps


class GoogleMapVC: UIViewController {
    
    @IBAction func saveAction(_ sender: Any) {
        saveButton(currentAddress)
    }
    
    var locationManager = CLLocationManager()
    let preciseLocationZoomLevel: Float = 15.0
    let approximateLocationZoomLevel: Float = 10.0
    
    
    @IBOutlet weak var saveBtn: UIButton!
    
    var mapView = GMSMapView()
    let marker = GMSMarker()
    
    
    var currentAddress = String()
    
    
    // MARK: - life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
        //        saveBtn.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
    }
    func setBtnViews(){
        
        view.addSubview(mapView)
        view.addSubview(saveBtn)
    }
    
    func saveButton(_ currentAddress:String){
        
        CoreDataGeneric.instance.AddToaddressesCoreD(address: currentAddress, compilation: { complete in
            print(complete)
            if let vc = self.navigationController?.viewControllers[2]{
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }, onError: { error in
            print(error)
            
            }
        )
    }
    
    func pageSetter(){
        saveBtn.layer.cornerRadius = 30
        
        
        self.saveBtn.layer.shadowOffset = CGSize(width: 0.0, height: 20.0)
        self.saveBtn.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        self.saveBtn.layer.shadowOpacity = 0.05
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
    }
    func reverseGeocoding(marker: GMSMarker) {
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(marker.position.latitude),Double(marker.position.longitude))
        
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                
                //                print("Response is = \(address)")
                //                print("Response is = \(lines)")
                self.currentAddress = lines.joined(separator: "\n")
            }
            marker.title = self.currentAddress
            marker.map = self.mapView
        }
    }
    
}

// MARK: - extensions
extension GoogleMapVC: CLLocationManagerDelegate, GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        reverseGeocoding(marker: marker)
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        marker.position = position.target
        reverseGeocoding(marker: marker)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.last!
        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
        let camera: GMSCameraPosition = GMSCameraPosition.camera(
            withLatitude:location.coordinate.latitude,
            longitude:location.coordinate.longitude,
            zoom: zoomLevel)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        setBtnViews()
        
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Marker default settings
        marker.position = location.coordinate
        self.mapView.delegate = self
        
        // next line is optional
        //         marker.map = mapView
        
        // if map hidden show it & move to camera position
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Check accuracy authorization
        let accuracy = manager.accuracyAuthorization
        switch accuracy {
        case .fullAccuracy:
            print("Location accuracy is precise.")
        case .reducedAccuracy:
            print("Location accuracy is not precise.")
        @unknown default:
            fatalError()
        }
        
        // Handle authorization status
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            fatalError()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
