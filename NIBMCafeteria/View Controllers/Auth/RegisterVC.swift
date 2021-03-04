//
//  RegisterVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-23.
//

import UIKit
import Firebase
import CoreLocation


class RegisterVC: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference! = Database.database().reference()
    var locationManager = CLLocationManager()
    
    
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:Functions
    func registerUser(){
        
        // Create cleaned versions of the data
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                let okAction = AlertAction(title: .Ok)
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: err?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.emailTextField.text = ""
                        self.phoneTextField.text = ""
                        self.passwordTextField.text = ""
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
            else {
                self.ref.child("users").child(result?.user.uid ?? "").setValue(["userID":result?.user.uid,"email":email, "phone":phone,"password":password])
                
                let okAction = AlertAction(title: .Ok)
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Registered Successfully" , actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.emailTextField.text = ""
                        self.phoneTextField.text = ""
                        self.passwordTextField.text = ""
                        
                        self.initLocationManager()
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
                
            }
            
        }
    }
    
    
    //MARK:Actions
    @IBAction func registerAUser(_ sender: Any) {
        registerUser()
    }
    
    func initLocationManager(){
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                AlertProvider(vc: self).showAlertWithAction(title: "Access Needed", message: "Need permission to use the location services. Go to settings and unable access permission for location services", action: AlertAction(title: "Settings")) { (action) in
                    if action.title == "Settings" {
                        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
                    }
                }
                break
            case .authorizedAlways, .authorizedWhenInUse:
                
                break
            default :
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}
