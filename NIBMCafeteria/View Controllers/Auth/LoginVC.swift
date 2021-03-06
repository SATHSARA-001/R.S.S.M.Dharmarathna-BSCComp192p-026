//
//  LoginVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-23.
//

import UIKit
import Firebase
import CoreLocation

class LoginVC: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK:Variables
    var ref: DatabaseReference! = Database.database().reference()
    
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    //MARK:Functions
    
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
    
    func loginUser(){
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Check Validations
        
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
                let defaults = UserDefaults.standard
                
                defaults.set(result?.user.uid, forKey: "userID")
                defaults.set(result?.user.phoneNumber, forKey: "phoneNumber")
                defaults.set(result?.user.email, forKey: "userName")
                
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
    
    @IBAction func resetPassword(_ sender: Any) {
        
        self.ref.child("users").getData { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
            }
            else {
                print("No data available")
            }
        }
    }
}
