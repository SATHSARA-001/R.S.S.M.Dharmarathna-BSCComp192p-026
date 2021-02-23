//
//  RegisterVC.swift
//  NIBMCafeteria
//
//  Created by Elegant Media on 2021-02-23.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func loginUser(){
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                print("Error")
                //                // Couldn't sign in
                //                self.errorLabel.text = error!.localizedDescription
                //                self.errorLabel.alpha = 1
            }
            else {
                
                print("Logged In Succefully")
                //                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                //
                //                self.view.window?.rootViewController = homeViewController
                //                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
    @IBAction func login(_ sender: Any) {
        loginUser()
    }
    
    
    
    
}
