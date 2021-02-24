//
//  ResetPasswordVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-24.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func resetMyPassword(){
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().sendPasswordReset(withEmail: email ) { (error) in
            
            if error != nil{
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: error?.localizedDescription ?? "", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }else{
                let okAction = AlertAction(title: .Ok)
                
                AlertProvider(vc: self).showAlertWithActions(title: "Alert", message: "Reset Email Sent Succefully", actions: [okAction], completion: { action in
                    if action.title == .Ok {
                        self.emailTextField.text = ""
                        
                    } else {
                        // Will dismiss alertView by default
                    }
                })
            }
        }
    }
    
    @IBAction func resetMyPassword(_ sender: Any) {
        
        resetMyPassword()
    }
    
    
}
