//
//  MapViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 11/07/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SwiftyJSON

class customPin: NSObject,MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String,pinSubtitle:String,location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
}



class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

  
    @IBOutlet weak var map: MKMapView!
    
    var id: String = WbmDefaults.instance.getString(key: "id")
    var category:String = WbmDefaults.instance.getString(key: "controller")
    var mapArr = [Map]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        getDestinations(url: "\(AppUtils.returnBaseUrl())/patient/\(category)/view/\(id)")
        let locationManager = CLLocationManager()
        var currentLocation: CLLocation!
        
        locationManager.delegate =  self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        map.showsUserLocation = true
        map.delegate = self
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locationManager.location
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.60,longitudeDelta: 0.60)
            let mylocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
            
            let region: MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
             map.setRegion(region, animated: true)

        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        // Do any additional setup after loading the view.
    }
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      
        if annotation is MKUserLocation{
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = #imageLiteral(resourceName: "add_marker")
        annotationView.canShowCallout = true
//        annotationView.isDraggable = true
        return annotationView
    }



    func getDestinations(url:String){
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            if response.result.isSuccess{
                let json = JSON(response.result.value!)
                print(json)
                
                self.mapArr.append(Map(fromJson: json))
                print(self.mapArr[0].hospitalName)
                for map in self.mapArr{
                    let branchArr = map.branches
                    for i in branchArr!{
                        let coordinate = i.location.coordinates
                        print(coordinate!)
                        let branchName:String = i.branchName ?? ""
                        let branchAddress:String = i.branchAddress.address ?? ""
                        self.setMarks(lon: coordinate![0], lat: coordinate![1], title: branchName, subtitle: branchAddress)
                       
                    }
                    
                }
               
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapListViewController") as! MapListViewController
                vc.list = self.mapArr
            }
            else{
                Utils.showAlert(view: self, message: response.error!.localizedDescription, title: "Error")
            }
        }
    }

    func setMarks(lon: Double,lat: Double,title:String,subtitle:String){
        
        let mylocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let pin = customPin(pinTitle: title, pinSubtitle: subtitle, location: mylocation)
        self.map.addAnnotation(pin)
    }

}
