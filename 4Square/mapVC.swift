//
//  ViewController.swift
//  4Square
//
//  Created by Özgür  Elmaslı on 18.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import MapKit
import Parse

class mapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate{

  
    @IBOutlet weak var mapview: MKMapView!
    var manager = CLLocationManager()
    var enlem = ""
    var boylam = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapview.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let recogranizer = UILongPressGestureRecognizer(target: self, action: #selector(mapVC.chooselocation(gesturereco:)))
        recogranizer.minimumPressDuration = 3
        mapview.addGestureRecognizer(recogranizer)
        
 
 
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapview.setRegion(region, animated: true)
 
    }
    override func viewWillAppear(_ animated: Bool) {
        self.enlem = ""
        self.boylam = ""
    }
    @IBAction func cancelbutton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func savebuttonclicked(_ sender: Any) {
        
        let object = PFObject(className: "places")
        object["name"] = globalname
        object["type"] = globaltype
        object["atmosphare"]  = globalatmosphare
        object["enlem"] = self.enlem
        object["boylam"] = self.boylam
        if let imagedata = UIImageJPEGRepresentation(globalimage, 0.5)
        {
            object["image"] = PFFile(name: "image.jpg", data: imagedata)
        }
        object.saveInBackground { (Succes, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                self.performSegue(withIdentifier: "gotoplacesVC", sender: nil)
            }
            
        }
        
    }
    @objc func chooselocation(gesturereco : UIGestureRecognizer )
    {
        if gesturereco.state == UIGestureRecognizerState.began
        {
            let touches = gesturereco.location(in: self.mapview)
            let coordinates = self.mapview.convert(touches, toCoordinateFrom: self.mapview)
            let anotation = MKPointAnnotation()
            anotation.coordinate = coordinates
            anotation.title = globalname
            anotation.subtitle = globaltype
            self.mapview.addAnnotation(anotation) // pini ekleyerek özellik ekledik
            
            self.enlem = String(coordinates.latitude)
            self.boylam = String(coordinates.longitude)
        }
    }
    

}
