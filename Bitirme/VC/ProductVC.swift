//
//  ProductVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import CoreLocation

class ProductVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var makeCommentButton: UIButton!
    
    var barcodeNumber: String!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topView.layer.cornerRadius = 5
        // topView.layer.backgroundColor = UIColor(red: 0.898, green: 0.498, blue: 0.518, alpha: 1.0).cgColor //koyu pembe
        topView.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor //koyu petrol
        displayView.layer.cornerRadius = 10
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.value(forKey: "Username") == nil {

        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func makeCommentButtonPressed(_ sender: Any) {
       if UserDefaults.standard.value(forKey: "Username") != nil {
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
            //vc.barcodeNumber = self.barcodeNumber data geçişi için belki barcode gönderilir marka anlaşılsın diye
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
        print("Success \(String(describing: locations.first))")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed \(error)")
    }
}
