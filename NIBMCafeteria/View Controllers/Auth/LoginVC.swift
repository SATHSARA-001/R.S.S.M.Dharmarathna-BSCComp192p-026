//
//  LoginVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-23.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    //MARK:Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: DatabaseReference! = Database.database().reference()

    
    //MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:Functions
    func loginUser(){
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                let okAction = AlertAction(title: .Ok)
                
                self.ref.child("foods").child("Ice Cream").setValue(["categoryID":"des","foodname":"Ice Cream","foodprice":"50","foodDescription":"Vanila ice cream ","offer":"10"])
                
                let mainstoryboard = UIStoryboard(name: "TabBarController", bundle: nil)
                let viewController = mainstoryboard.instantiateViewController(withIdentifier: "MainTBC") as! UITabBarController
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
                
//                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: error?.localizedDescription ?? "", actions: [okAction], completion: { action in
//                    if action.title == .Ok {
//                        
//                    } else {
//                        // Will dismiss alertView by default
//                    }
//                })
            }
            else {
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
        loginUser()
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
