//
//  MainTBC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-24.
//

import UIKit
import CoreLocation


class MainTBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isLocationAccessEnabled()
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
    
    
    func isLocationAccessEnabled() {
        
       if CLLocationManager.locationServicesEnabled() {
          switch CLLocationManager.authorizationStatus() {
             case .notDetermined, .restricted, .denied:
                print("No access")
             case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
          }
       } else {
          print("Location services not enabled")
        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainstoryboard.instantiateViewController(withIdentifier: "RequestLocationVC") as! RequestLocationVC
        self.present(viewController, animated: true,completion: nil)
       }
    }
    
    
}
