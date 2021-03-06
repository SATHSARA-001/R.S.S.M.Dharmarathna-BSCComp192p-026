//
//  RequestLocationVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-24.
//

import UIKit
import CoreLocation


class RequestLocationVC: UIViewController {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationManager()
        // Do any additional setup after loading the view.
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
    
    @IBAction func popView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

