//
//  RegisterVC.swift
//  NIBMCafeteria
//
//  Created by Elegant Media on 2021-02-23.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func registerUser(){
        
        // Create cleaned versions of the data
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                
            }
            else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["email":email, "phone":phone,"password":password, "uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
                    }
                }
                print("succefuly added")
            }
            
        }
    }
    
    
    @IBAction func registerAUser(_ sender: Any) {
        registerUser()
    }
    
    
}
