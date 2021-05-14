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
    @IBOutlet weak var makeCommentButton: UIButton!
    @IBOutlet weak var seeAllCommentsButton: UIButton!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totallikesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var actionView: UIView!
    
    var barcodeNumber: String!
    var productID: String = ""
    let locationManager = CLLocationManager()
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    var storeName: String = ""
    var productsArray: [ScanProduct] = []
    var theProduct: [ScanProduct] = []
    var imageUrlArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.topView.layer.cornerRadius = 5
        self.topView.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor
        
        self.actionView.addShadow(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0))
        
        self.seeAllCommentsButton.addShadowformaButtons(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 10.0, corners: [.allCorners] )
        self.likeButton.addShadowformaButtons(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 10.0, corners: [.allCorners])
        self.makeCommentButton.addShadowformaButtons(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 10.0, corners: [.allCorners])
        
        //        self.seeAllCommentsButton.setImage(UIImage(named: "barcodeProduct"), for: .normal)
        self.locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        self.longitude = Double(locationValue.longitude)
        //        self.latitude = Double(locationValue.latitude)
        
        let params: [String: Any] = ["barcode": self.barcodeNumber! ,
                                     "latitude": 41.048106,
                                     "longitude": 29.081074]
        NetworkManager.sendScanRequest(parameters: params)
        { [weak self] (data, error) in
            if let error = error {
                print("ERROR:\(error)")
                return
            }
            if let dictionary = data {
                self!.storeName = String((dictionary.name)!)
                self!.productsArray = (dictionary.products)!
                self!.storeLabel.text = String(self!.storeName)
                let products = dictionary.products
                
                for item in products! {
                    let tempBarcode = item.barcode
                    if (String(tempBarcode!) == self?.barcodeNumber){
                        self?.theProduct.append(item)
                    }
                }
                self?.colorLabel.text = "Color: \(String(Int(self!.theProduct[0].color!)))"
                self?.sizeLabel.text = "Size: \(String(Int(self!.theProduct[0].size!)))"
                self?.priceLabel.text = "Price: \(String(Double(self!.theProduct[0].price!)))"
                self?.totallikesLabel.text = "\(String(Int(self!.theProduct[0].likeNumber!))) people have liked this product"
                self?.nameLabel.text = String(self!.theProduct[0].name!)
                self?.productID = String(self!.theProduct[0].id!)
                for item in self!.theProduct[0].productImages! {
                    self?.imageUrlArray.append(String(item.path!))
                }
                let imageUrlString = "http://192.168.1.155/ProductImages/\(String(describing: self?.imageUrlArray[0]))"
                guard let imageUrl:URL = URL(string: imageUrlString) else {
                    return
                }
                self?.imageView.loadImge(withUrl: imageUrl)
            }
        }
        
        let imageUrlString = "http://192.168.1.155/ProductImages/2f79ecd8-2b8c-401b-9d6c-e27e7c8d2ca1.jpg"
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        imageView.loadImge(withUrl: imageUrl)
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
        vc.productID = self.productID
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

extension UIView {
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}


extension UIButton {
    func addShadowformaButtons(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner) {
        let fillColor: UIColor = UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0)
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}

extension UIImageView {
    func loadImge(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
