//
//  ProductVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import CoreLocation
import SwiftKeychainWrapper

class ProductVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var makeCommentButton: UIButton!
    
    var barcodeNumber: String!
    let locationManager = CLLocationManager()
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topView.layer.cornerRadius = 5
        topView.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor //koyu petrol
        displayView.layer.cornerRadius = 10
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.longitude = Double(locationValue.longitude)
//        self.latitude = Double(locationValue.latitude)
        
        let params: [String: Any] = ["barcode": self.barcodeNumber!,
                                     "latitude": 41.048106,
                                     "longitude": 29.081074]
        NetworkManager.sendScanRequest(parameters: params)
        { [weak self] (data, error) in
            if let error = error {
                print("Error:\(error)")
                return
            }
            print("asdfghjkljhgfdsa")
            print(data!)
    }
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func seeAllCommentsButtonPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SeeAllCommentsVC") as! SeeAllCommentsVC
        vc.modalPresentationStyle = .fullScreen
        //        vc.barcodeNumber = self.barcodeNumber
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func makeCommentButtonPressed(_ sender: Any) {
        if KeychainWrapper.standard.string(forKey: "username") != nil {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "makeCommentVC") as! MakeCommentVC
            vc.modalPresentationStyle = .popover
            vc.barcodeNumber = self.barcodeNumber
            present(vc, animated: true, completion: nil)
        }
        else{
            let window = UIApplication.shared.keyWindow!
            let backgroundView = UIView(frame: window.bounds)
            window.addSubview(backgroundView)
            backgroundView.backgroundColor = UIColor.init(displayP3Red: 0.954, green: 0.934, blue: 0.925, alpha: 0.95)
            view.addSubview(backgroundView)
            let gif = UIImage.gifImageWithName("signInError")
            let imageView = UIImageView(image: gif)
            imageView.frame = CGRect(x: -20, y: 285, width: 467.25, height: 350)
            view.addSubview(imageView)
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                imageView.removeFromSuperview()
                backgroundView.removeFromSuperview()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        // 1
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        // 2
        case .denied, .restricted:
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "locationVC") as! LocationVC
            vc.modalPresentationStyle = .popover
            vc.barcodeNumber = self.barcodeNumber
            present(vc, animated: true, completion: nil)
            return
            
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
            break
            
        @unknown default:
            print("unknown")
            fatalError()
        }
        // 4
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue: CLLocationCoordinate2D = manager.location!.coordinate
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("Failed \(error)")
    }
}
