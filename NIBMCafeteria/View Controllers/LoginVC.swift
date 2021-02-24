//
//  LoginVC.swift
//  NIBMCafeteria
//
//  Created by Elegant Media on 2021-02-23.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func loginUser(){
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: error?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
            else {
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Loggin Succefully", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
    
}
