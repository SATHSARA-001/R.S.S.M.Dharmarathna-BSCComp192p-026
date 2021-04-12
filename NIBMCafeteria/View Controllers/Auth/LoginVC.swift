//
//  LoginVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-23.
//

import UIKit
import FirebaseStorage
import Firebase
import CoreLocation

class LoginVC: UIViewController,LoadingIndicatorDelegate {
    
    //MARK:Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK:Variables
    var ref: DatabaseReference! = Database.database().reference()
    let defaults = UserDefaults.standard
    
    
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAccess()
        emailTextField.text = "sathsara@gmail.com"
        passwordTextField.text = "12345678"
    }
    
    func checkLocationAccess(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainstoryboard.instantiateViewController(withIdentifier: "RequestLocationVC") as! RequestLocationVC
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true,completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    //MARK:Functions
    
    //Mark Validate Fields
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the email is correct format
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isValidEmailAddress(email: cleanedEmail) == false{
            return "Invalid formatted email address"
        }
        
        return nil
    }
    
    //MARK:Login User Network Request
    
    func getUserDetailsByUserID(userIDTxt:String?) {
        self.startLoading()
        let userID = userIDTxt ?? ""
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            self.defaults.set(username, forKey: "userName")
            print(username)
            self.stopLoading()
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func loginUser(){
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            print(result as Any)
            if error != nil {
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Error", message: error?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
                
            }
            else {
                
                
                self.defaults.set(result?.user.uid, forKey: "userID")
                self.defaults.set(result?.user.phoneNumber, forKey: "phoneNumber")
                
                let userID = self.defaults.string(forKey: "userID") ?? ""
                
                self.getUserDetailsByUserID(userIDTxt: userID)
                
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Loggin Succefully", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        
                        let mainstoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
                        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MainTBC") as! UITabBarController
                        self.view.window?.rootViewController = viewController
                        self.view.window?.makeKeyAndVisible()
                        
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    
    
    //MARK:Actions
    @IBAction func login(_ sender: Any) {
        
        let validation = validateFields()
        
        if validation == nil{
            loginUser()
        }else{
            let okAction = AlertAction(title: .Ok)
            
            AlertProvider(vc: self).showAlertWithActions(title: "Error", message:validation ?? "", actions: [okAction], completion: { action in
                if action.title == .Ok {
                } else {
                    // Will dismiss alertView by default
                }
            })
        }
    }
    @IBAction func forgetPasswordView(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        
        self.navigationController?.pushViewController(targetVC, animated: true)
        
    }
    
}
