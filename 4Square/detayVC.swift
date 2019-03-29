//
//  ViewController.swift
//  4Square
//
//  Created by Özgür  Elmaslı on 18.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse
import MapKit

class detayVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var selectedplace  = ""
    var secilenenmel = ""
    var secilenboylam = ""
    var namearray = [String]()
    var typearray = [String]()
    var atmospharearray = [String]()
    var enlemarray = [String]()
    var boylamarray = [String]()
    var imagearray = [PFFile]()
    
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var placeatmosphare: UILabel!
    @IBOutlet weak var placetype: UILabel!
    @IBOutlet weak var placename: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    var manager = CLLocationManager()
    var requestmanager = CLLocation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapview.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        parsedancek()

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // secilenlokasyonu gösterme
        if self.secilenboylam != "" && self.secilenboylam != ""
        {
            let location = CLLocationCoordinate2D(latitude: Double(self.secilenenmel)!, longitude: Double(self.secilenboylam)!)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapview.setRegion(region, animated: true)
            
            let anotation = MKPointAnnotation()
            anotation.coordinate =  location
            anotation.title = self.namearray.last!
            anotation.subtitle = self.typearray.last!
            self.mapview.addAnnotation(anotation)
            
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        
        let reuseıd = "pin"
        var pinview = mapview.dequeueReusableAnnotationView(withIdentifier: reuseıd)
        if pinview == nil
        {
            pinview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseıd)
            pinview?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinview?.rightCalloutAccessoryView = button
            
        }
        else
        {
            pinview?.annotation = annotation
        }
        return pinview
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if secilenenmel != "" && secilenboylam != ""
        {
            self.requestmanager = CLLocation(latitude: Double(self.secilenenmel)!, longitude: Double(self.secilenboylam)!)
            CLGeocoder().reverseGeocodeLocation(requestmanager, completionHandler: { (Placemark, error) in
              if let placemarks = Placemark
              {
                   if placemarks.count > 0
                   {
                    let mkPlacemarks = MKPlacemark(placemark: placemarks[0])
                    let mapitem = MKMapItem(placemark: mkPlacemarks)
                    mapitem.name = self.namearray.last!
                    let launchoptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    mapitem.openInMaps(launchOptions: launchoptions)
                    
                   }
               }
            })
        }
    }
    func parsedancek()
    {
      let query = PFQuery(className: "places")
       query.whereKey("name", equalTo: self.selectedplace)
        query.findObjectsInBackground { (objects, error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                self.namearray.removeAll(keepingCapacity: false)
                 self.typearray.removeAll(keepingCapacity: false)
                 self.atmospharearray.removeAll(keepingCapacity: false)
                 self.enlemarray.removeAll(keepingCapacity: false)
                 self.boylamarray.removeAll(keepingCapacity: false)
                  self.imagearray.removeAll(keepingCapacity: false)
                   for object in objects!
                   {
                    self.namearray.append(object.object(forKey: "name") as! String)
                    self.typearray.append(object.object(forKey: "type") as! String)
                    self.atmospharearray.append(object.object(forKey: "atmosphare") as! String)
                    self.enlemarray.append(object.object(forKey: "enlem") as! String)
                    self.boylamarray.append(object.object(forKey: "boylam") as! String)
                    self.imagearray.append(object.object(forKey: "image") as! PFFile)
                     self.placename.text = self.namearray.last!
                    self.placetype.text = self.typearray.last!
                    self.placeatmosphare.text = self.atmospharearray.last!
                    self.secilenenmel = self.enlemarray.last!
                    self.secilenboylam = self.boylamarray.last!
                     self.manager.startUpdatingLocation()
                    self.imagearray.last?.getDataInBackground(block: { (data, error) in
                        if error != nil
                        {
                            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(ok)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        else
                        {
                            self.imageview.image = UIImage(data: data!)
                        }
                    })
                    }
            }
        }
    }
}
