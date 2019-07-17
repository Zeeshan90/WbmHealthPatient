//
//  MapDetailViewController.swift
//  WbmHealth
//
//  Created by Zeeshan on 16/07/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//class customPin: NSObject,MKAnnotation{
//    var location: CLLocationCoordinate2D?
//    init(loc: CLLocationCoordinate2D) {
//        self.location = loc
//    }
//}
class MapDetailViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapVu: MKMapView!
    var location = CLLocation()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        mapVu.delegate = self
        locationManager.delegate = self
        location = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let source = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print(source)
//        let source = CLLocationCoordinate2D(latitude: 39.173209, longitude: -94.593933)
        let destination = CLLocationCoordinate2D(latitude: 38.643172, longitude: -90.177429)
        let sourcePin = customPin(pinTitle: "", pinSubtitle: "", location: source)
         let desPin = customPin(pinTitle: "", pinSubtitle: "", location: destination)
        self.mapVu.addAnnotation(sourcePin)
        self.mapVu.addAnnotation(desPin)
        
        
        let sourcePlacemark = MKPlacemark(coordinate: source)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let directionReq = MKDirections.Request()
        directionReq.source = MKMapItem(placemark: sourcePlacemark)
        directionReq.destination = MKMapItem(placemark: destinationPlacemark)
        directionReq.transportType = .automobile
        
        let directions = MKDirections(request: directionReq)
        directions.calculate{ (response, error) in
            guard let directionResponse = response else {
                if let error = error{
                    print("error getting location: \(error.localizedDescription)")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.mapVu.addOverlay(route.polyline, level: .aboveRoads)
            
            
            let react = route.polyline.boundingMapRect
            self.mapVu.setRegion(MKCoordinateRegion(react), animated: true)
            }
        
        
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

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.black
        render.lineWidth = 3.0
        return render
    }
    
    
    
    
}
