//
//  SecondVC.swift
//  ObjectiveCProj
//
//  Created by Vivek on 8/10/20.
//  Copyright © 2020 Vivek. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMaps



enum TravelModes: Int {
    case driving
    case walking
    case bicycling
}
class SecondVC: UIViewController, GMSMapViewDelegate {
    var locationManager = CLLocationManager()
     
    var didFindMyLocation = false
    var travelMode = TravelModes.driving
    @IBOutlet weak var viewMap: GMSMapView!
    var longitudes:[Double]!
    var latitudes:[Double]!
    var architectNames:[String]!
    var completedYear:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Good work \(CalculationClass.addTwoItem(3.0, with: 4.0))")
        latitudes = [48.8566667,41.8954656,51.5001524]
               longitudes = [2.3509871,12.4823243,-0.1262362]
               architectNames = ["Stephen Sauvestre","Bonanno Pisano","Augustus Pugin"]
               completedYear = ["1889","1372","1859"]
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        else{
            print("Location service disabled");
        }
        //let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 8.0)
              // let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
              // self.view.addSubview(mapView)

        do {
          // Set the map style by passing the URL of the local file.
          if let styleURL = Bundle.main.url(forResource: "map", withExtension: "json") {
            viewMap.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            NSLog("Unable to find style.json")
          }
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }
        
       // viewMap.camera = camera
        //self.setOneMarker()
        self.loadMultipleMarker()
        viewMap.delegate = self

    }
    func setOneMarker(){
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 8.0)
         viewMap.camera = camera


                 // Creates a marker in the center of the map.
                 let marker = GMSMarker()
        //  let markerImage = UIImage(named: "map_car_running")!.withRenderingMode(.alwaysTemplate)

          //creating a marker view
        //  let markerView = UIImageView(image: markerImage)

          //changing the tint color of the image
         /// markerView.tintColor = UIColor.green
                 marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
                  //marker.iconView = markerView
          marker.icon = UIImage(named: "map_car_running.png")
                 marker.title = "Sydney"
                 marker.snippet = "Australia"
                 marker.map = viewMap
          //marker.infoWindowAnchor = cgp //CGPointMake(0.5, 0.2)
          marker.accessibilityLabel = "i"
          viewMap.selectedMarker = marker
    }
    func loadMultipleMarker(){

        for i in 0...2 {
           let coordinates = CLLocationCoordinate2D(latitude: latitudes[i], longitude: longitudes[i])
           let marker = GMSMarker(position: coordinates)
           marker.map = self.viewMap
           marker.icon = UIImage(named: "\(i)")
          // marker.infoWindowAnchor = CGPointMake(0.5, 0.2)
           marker.accessibilityLabel = "\(i)"
        }
      
      
    }
    func checkUsersLocationServicesAuthorization(){
        /// Check if user has authorized Total Plus to use Location Services
        if CLLocationManager.locationServicesEnabled()
        {
            switch CLLocationManager.authorizationStatus()
            {
            case .notDetermined:
                // Request when-in-use authorization initially
                // This is the first and the ONLY time you will be able to ask the user for permission
                self.locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                break

            case .restricted, .denied:
                // Disable location features
                print("Location Access Not Available")
                break

            case .authorizedWhenInUse, .authorizedAlways:
                // Enable features that require location services here.
                print("Location Access Available")
                break
            @unknown default:
                print("error")
            }
        }
    }

    @IBAction func changeMapType(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type:", preferredStyle: UIAlertController.Style.actionSheet)
     
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.viewMap.mapType = .normal
        }
        let satelliteMapTypeAction = UIAlertAction(title: "Satellite", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.viewMap.mapType = .satellite
        }
     
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.viewMap.mapType = .terrain
        }
     
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.viewMap.mapType = .hybrid
        }
     
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
     
        }
     
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(satelliteMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
     
        present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func findAddress(sender: AnyObject) {
        let addressAlert = UIAlertController(title: "Address Finder", message: "Type the address you want to find:", preferredStyle: UIAlertController.Style.alert)
     
        addressAlert.addTextField { (textField) -> Void in
            textField.placeholder = "Address?"
        }
     
        let findAction = UIAlertAction(title: "Find Address", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            let address = (addressAlert.textFields![0] as UITextField).text as! String
     print(address)
           // self.mapTasks.geocodeAddress(address, withCompletionHandler: { (status, success) -> Void in
     
          //  })
     
        }
     
        let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
     
        }
     
        addressAlert.addAction(findAction)
        addressAlert.addAction(closeAction)
     
        present(addressAlert, animated: true, completion: nil)
    }
//
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
       // 1
       let index:Int! = Int(marker.accessibilityLabel!)
       // 2
        let customInfoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)![0] as! CustomInfoWindow
       customInfoWindow.architectLbl.text = architectNames[index]
       customInfoWindow.completedYearLbl.text = completedYear[index]
        customInfoWindow.backgroundColor = .gray
       return customInfoWindow
    }
    @IBAction func changeTravelMode(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Travel Mode", message: "Select travel mode:", preferredStyle: UIAlertController.Style.actionSheet)
     
        let drivingModeAction = UIAlertAction(title: "Driving", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.travelMode = TravelModes.driving
            //self.recreateRoute()
        }
     
        let walkingModeAction = UIAlertAction(title: "Walking", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.travelMode = TravelModes.walking
           // self.recreateRoute()
        }
     
        let bicyclingModeAction = UIAlertAction(title: "Bicycling", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.travelMode = TravelModes.bicycling
           // self.recreateRoute()
        }
     
        let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
     
        }
     
        actionSheet.addAction(drivingModeAction)
        actionSheet.addAction(walkingModeAction)
        actionSheet.addAction(bicyclingModeAction)
        actionSheet.addAction(closeAction)
     
        present(actionSheet, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SecondVC: CLLocationManagerDelegate{
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let loc: CLLocation = locations.last!
    viewMap.isMyLocationEnabled = true
     locationManager.stopUpdatingLocation()
   // viewMap.camera = GMSCameraPosition.camera(withTarget: loc.coordinate, zoom: 10.0)
           viewMap.settings.myLocationButton = true
    
           didFindMyLocation = true
     
 }
 func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
     print("Location manager failed with error = \(error.localizedDescription)")
     
 }
}
