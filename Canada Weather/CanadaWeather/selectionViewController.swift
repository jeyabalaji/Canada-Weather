//
//  selectionViewController.swift
//  XMLParsingDemo
//
//  Created by Jeya Balaji on 01/11/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class selectionViewController: UIViewController,CLLocationManagerDelegate,NSURLConnectionDelegate {

    let locationManager = CLLocationManager()
    
    var latitude = 0.00;
    var Longitude = 0.00;
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "AIzaSyDkbJaLJuw2RoOU21ydR0y61g9DTUyPpnM"
    var newlat:String = "+19.01761470"
    var newlong:String = "+72.85616440"
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "img1")!)
        super.viewDidLoad()
        locationManager.delegate = self
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location11 = locations.first {
            print("Found User's location: \(location11)")
            print("Latitude: \(location11.coordinate.latitude) Longitude: \(location11.coordinate.longitude)")
            latitude = location11.coordinate.latitude
            newlat = String(location11.coordinate.latitude)
            Longitude = location11.coordinate.longitude
            newlong = String(location11.coordinate.longitude)
            getAddressForLatLng(newlat,newlong: newlong)
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func getAddressForLatLng(newlat: String, newlong: String) {
        let url = NSURL(string: "\(baseUrl)latlng=\(newlat),\(newlong)&key=\(apikey)")
        let data = NSData(contentsOfURL: url!)
        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        if let result = json["results"] as? NSArray {
            if let address = result[0]["address_components"] as? NSArray {
                let number = address[0]["short_name"] as! String
                let street = address[1]["short_name"] as! String
                let city = address[4]["short_name"] as! String
                let state = address[4]["short_name"] as! String
                let zip = address[6]["short_name"] as! String
                print("\n\(number) \(street), \(city), \(state) \(zip)")
                print(city)
            }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
