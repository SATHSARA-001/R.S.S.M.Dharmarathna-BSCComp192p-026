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
                
                //                self.ref.child("categories").child("breakfast").setValue(["categoryID":"brkfst","categoryName":"Breakfast"])
                //                self.ref.child("categories").child("lunch").setValue(["categoryID":"lnch","categoryName":"Lunch"])
                //                self.ref.child("categories").child("dinner").setValue(["categoryID":"dnr","categoryName":"Dinner"])
                
                //                self.ref.child("foods").child("Bread").setValue(["categoryID":"brkfst","foodDescription":"Bread with dhal","foodname":"Bread","foodprice":"120"])
                
                //                self.ref.child("foods").child("FriedRice").setValue(["categoryID":"dnr","foodDescription":"Chineese Fried Rice","foodname":"Fried Rice","foodprice":"250","offer":"12"])
                //
                //                self.ref.child("foods").child("WaterMelon").setValue(["categoryID":"Drnk","foodDescription":"Water Melon Juice","foodname":"WaterMelon","foodprice":"120","offer":"5"])
                //
                //                self.ref.child("foods").child("RiceWithChicken").setValue(["categoryID":"lnch","foodDescription":"White rice with Chicken","foodname":"Rice With Chicken","foodprice":"180"])
                
                
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
