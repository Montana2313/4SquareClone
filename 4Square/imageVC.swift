//
//  ViewController.swift
//  4Square
//
//  Created by Özgür  Elmaslı on 18.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit


var globalname = ""
var globaltype = ""
var globalatmosphare = ""
var globalimage = UIImage()

class imageVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

 
    @IBOutlet weak var atmosphare: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var placetype: UITextField!
    @IBOutlet weak var placename: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageVC.selectimage))
        image.addGestureRecognizer(tap)
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap2)
    }
    @objc func selectimage()
    {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        globalname = ""
        globaltype = ""
        globalimage = UIImage()
        globalatmosphare = ""
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        image.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @IBAction func bookmark(_ sender: Any) {
        
        if placename.text != "" && placetype.text != "" && atmosphare.text != ""
        {
            if let choosenimage = image.image
            {
                globalname = placename.text!
                globaltype = placetype.text!
                globalatmosphare = atmosphare.text!
                globalimage = choosenimage
                
            }
        }
        placename.text = ""
        placetype.text = ""
        atmosphare.text = ""
        image.image = UIImage(named: "img1.jpg")
        self.performSegue(withIdentifier: "tomapVC", sender: nil)
    }
    @IBAction func nextbutton(_ sender: Any) {
    }
}
