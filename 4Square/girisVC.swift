//
//  ViewController.swift
//  4Square
//
//  Created by Özgür  Elmaslı on 18.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

class girisVC: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(girisVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    @IBAction func girisbutton(_ sender: Any) {
        
        if username.text != "" && password.text != ""
        {
            PFUser.logInWithUsername(inBackground: username.text!, password: password.text!, block: { (user, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                   UserDefaults.standard.set(self.username.text!, forKey: "user")
                    UserDefaults.standard.synchronize()
                    let delegate  : AppDelegate  = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberlogin()
                 
                }
                
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Need", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    @IBAction func createdbutton(_ sender: Any) {
        
        if username.text != "" && password.text != ""
        {
            let user = PFUser()
            user.username = username.text!
            user.password = password.text!
            user.signUpInBackground(block: { (Succes, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("Created")
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Need", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

