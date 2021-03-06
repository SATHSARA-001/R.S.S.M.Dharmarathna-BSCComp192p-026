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
    
    //MARK:Variables
    var ref: DatabaseReference! = Database.database().reference()
    var locationManager = CLLocationManager()
    
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:Functions
    
    //MARK:Validations
    func validateFields() -> String? {
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPhone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // MARK:Check that all fields are filled in
        if cleanedEmail == "" || cleanedPhone == "" || cleanedPassword == ""{
            return "Please fill in all fields."
        }
        // MARK:Check that valid email entered
        if Utilities.isValidEmailAddress(email: cleanedEmail) == false{
            return "Invalid  email address"
        }
        // MARK:Check that valid phone number entered
        if Utilities.isValidPhoneNumber(phone: cleanedPhone) == false{
            return "Invalid phone number"
        }
        // MARK:Check that valid password entered
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Password should contan 8 charcters with special character"
        }
        
        return nil
    }
    
    //MARK:Register User Nwtwork Request
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
                        
                        let defaults = UserDefaults.standard
                        
                        defaults.set(result?.user.uid, forKey: "userID")
                        defaults.set(result?.user.phoneNumber, forKey: "phoneNumber")
                        defaults.set(result?.user.email, forKey: "userName")
                        
                        let mainstoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
                        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MainTBC") as! UITabBarController
                        self.view.window?.rootViewController = viewController
                        self.view.window?.makeKeyAndVisible()
                        
                        self.emailTextField.text = ""
                        self.phoneTextField.text = ""
                        self.passwordTextField.text = ""
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    
    
    //MARK:Actions
    @IBAction func registerAUser(_ sender: Any) {
        
        let validation = validateFields()
        
        if validation == nil{
            registerUser()
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
}
