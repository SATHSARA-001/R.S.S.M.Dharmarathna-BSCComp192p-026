//
//  MainTBC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-24.
//

import UIKit
import CoreLocation
import Firebase



class MainTBC: UITabBarController,CLLocationManagerDelegate {
    
    
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    var ordersList = [CartObject]()
    var longitude:CLLocationDegrees?
    var latitude:CLLocationDegrees?
    var trigger:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLocationAccessEnabled()
        fetchOrders()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.4, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc func update() {
        fetchOrders()
        if ordersList.count > 0{
            print(self.longitude)
            print(self.latitude)
            let a = CLLocation(latitude: self.latitude ?? 1, longitude: self.longitude ?? 1)
            let b = CLLocation(latitude: 55.0260565, longitude: 22.32601042)
            let c = a.distance(from: b)
            if c < 10{
                updateStatus()
            }
            print(c)
            print("@@@@@@@@")
        }
    }
    
    func updateStatus(){
        //update orders and
        let ref: DatabaseReference! = Database.database().reference()
        
        for order in ordersList {
            ref.child("orders").child(order.orderID ?? "").updateChildValues(["orderStatus": 4])
            
        }
        
        
    }
    
    func fetchOrders(){
        
        let orderList: DatabaseReference! = Database.database().reference().child("orders")
        
        orderList.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.ordersList.removeAll()
                
                for orders in snapshot.children.allObjects as! [DataSnapshot]{
                    let categoryObject = orders.value as? [String: AnyObject]
                    
                    let cart  = categoryObject?["cart"]
                    let time  = categoryObject?["time"]
                    let userID  = categoryObject?["userID"]
                    let totalAmt  = categoryObject?["totalAmt"]
                    let orderStatus = categoryObject?["orderStatus"]
                    let userName = categoryObject?["userName"]
                    let orderID = categoryObject?["orderID"]
                    let orderLocationLatitude = categoryObject?["orderLocationLatitude"]
                    let orderLocationLongitude = categoryObject?["orderLocationLongitude"]
                    
                    let cartObject = CartObject(cart: cart as? [Cart], time: time as? String, userID: userID as? String, userName: userName as? String, totalAmt: totalAmt as? String,orderStatus:orderStatus as? Int, orderID: orderID as? String,orderLocationLatitude: orderLocationLatitude as? String,orderLocationLongitude: orderLocationLongitude as? String)
                    
                    let userid = self.defaults.string(forKey: "userID")
                    
                    if cartObject.userID == userid && cartObject.orderStatus == 3{
                        self.ordersList.append(cartObject)
                        
                    }
                    
                    print(self.ordersList.count)
                    print(self.ordersList)
                }
                
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.longitude = locValue.longitude
        self.latitude = locValue.latitude
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
