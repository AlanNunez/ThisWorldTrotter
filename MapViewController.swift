//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Cristopher Nunez on 12/6/18.
//  Copyright © 2018 com.example.flia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    var locationManager = CLLocationManager.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        class MyAnnotation: NSObject, MKAnnotation {
            var title : String?
            var subTit : String?
            var coordinate : CLLocationCoordinate2D

            init(title:String, coordinate: CLLocationCoordinate2D,subtitle:String){
                self.title = title;
                self.coordinate = coordinate;
                self.subTit = subtitle;
            }
        }
        let latitudeToBe:CLLocationDegrees = 18.475029
        let longitudeToBe:CLLocationDegrees = -69.8312713
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeToBe, longitudeToBe)
        let latitudeBirth:CLLocationDegrees = 18.475680
        let longitudeBirth:CLLocationDegrees = -69.877357
        
        let locationSec:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeBirth, longitudeBirth)
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(7, 7)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let myAn1 = MyAnnotation(title: "Birth place", coordinate: location, subtitle: "MyOffice");
        let myAn2 = MyAnnotation(title: "Place to be", coordinate: locationSec, subtitle: "MyOffice 1");
        
        mapView.addAnnotations([myAn1, myAn2])
        print("MapViewController loaded its view.")
    }
    var mapView: MKMapView!
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        let margins = view.layoutMarginsGuide
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("My location", for: [])
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        mapView.addSubview(button)
        button.topAnchor.constraint(equalTo:  segmentedControl.bottomAnchor, constant: 12).isActive = true
        button.leadingAnchor.constraint(equalTo:  segmentedControl.leadingAnchor).isActive = true
        let pin = MKPinAnnotationView()
        mapView.addSubview(pin)
    }
    @objc func mapTypeChanged(_ segControl: UISegmentedControl)
    {
        switch segControl.selectedSegmentIndex
        {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    @objc func buttonAction(_ sender: UIButton) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
        mapView.setRegion(region, animated: true)
    }
}
