//
//  ViewController.swift
//  4Square
//
//  Created by Özgür  Elmaslı on 18.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class placesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var placesnamearray = [String]()
    var choosenplace = ""
    override func viewDidLoad() {
        super.viewDidLoad()
           tableview.delegate = self
           tableview.dataSource = self
           datacek()
    }
    func datacek()
    {
         let query = PFQuery(className: "places")
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
                self.placesnamearray.removeAll(keepingCapacity: false)
                for object in objects!
                {
                    self.placesnamearray.append(object.object(forKey: "name") as! String)
                }
                self.tableview.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.choosenplace = placesnamearray[indexPath.row]
        self.performSegue(withIdentifier: "todetailVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todetailVC"
        {
            let destinationVC = segue.destination as! detayVC
            destinationVC.selectedplace = self.choosenplace
        }
    }
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let singinvc = self.storyboard?.instantiateViewController(withIdentifier: "girisVC") as! girisVC
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = singinvc
        delegate.rememberlogin()
    }
    @IBAction func addclicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toimageVC", sender: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return placesnamearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text =  placesnamearray[indexPath.row]
        return cell
    }
    
 

}
