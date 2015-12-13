//
//  MapViewController.swift
//  iOS_Final
//
//  Created by Zhihe, Jing on 12/5/15.
//  Copyright © 2015 Zhihe, Jing. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapview: MKMapView!
    let locationManager = CLLocationManager()
    
    /*
    let initiallocaiton = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation (Location: CLLocation){
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(Location.coordinate, regionRadius*2.0, regionRadius*2.0)
        
        mapview.setRegion(coordinateRegion, animated: true)
    }

*/
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapview.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        //centerMapOnLocation(initiallocaiton)
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
      //  locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
          //  mapview.showsUserLocation = true
        }
    }
    
    
    // MARK: -location delegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        self.mapview.setRegion(region, animated: true)
       
        //locationManager.stopUpdatingLocation()
        
        
        NSLog("location?.description"
        
        print("location detected");
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    locationManager.stopUpdatingLocation()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        locationManager.startUpdatingLocation();
    }
    */
    
}