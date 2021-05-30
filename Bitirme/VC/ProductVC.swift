//
//  ProductVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import CoreLocation
import SwiftKeychainWrapper


class ProductVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var makeCommentButton: UIButton!
    @IBOutlet weak var seeAllCommentsButton: UIButton!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totallikesLabel: UILabel!
    @IBOutlet weak var totalscansLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var actionView: UIView!
    
    var barcodeNumber: String!
    var productID: String = ""
    let locationManager = CLLocationManager()
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    var productTypeID: String = ""
    
    var liked: Bool = false
    var storeName: String = ""
    var productsArray: [ScanProduct] = []
    var theProduct: [ScanProduct] = []
    var imageUrlArray: [String] = []
    @IBOutlet weak var photosCollectionView: UICollectionView!
    let photosCollectionViewIdentifier = "PhotosofProductCell"
    @IBOutlet weak var pageControl: UIPageControl!
    var currentIndex = 0
    
    var allColors: [Int] = [1,2,3,4,5,6,7,8]
    var existcolors: [Int] = [4,6,7]
    var allSizes: [Int] = [1,2,3]
    var existSizes: [Int] = [1,3]
    
    var colorButtons: [UIButton] = []
    var sizeButtons: [UIButton] = []
    let colorDict: [Int: UIColor] = [1:UIColor.black.withAlphaComponent(0.7), 2:UIColor.white.withAlphaComponent(0.8), 3:UIColor(red: 0.698, green: 0.0784, blue: 0, alpha: 0.8), 4:UIColor(red: 0.898, green: 0.4784, blue: 0, alpha: 0.8), 5:UIColor(red: 0.898, green: 0.8392, blue: 0, alpha: 1.0), 6:UIColor(red: 0.4275, green: 0.7569, blue: 0, alpha: 0.8), 7:UIColor(red: 0, green: 0.5569, blue: 0.698, alpha: 0.8), 8:UIColor(red: 154/255, green: 0/255, blue: 154/255, alpha: 0.8)]
    
    let colorNamesDict:[Int: String] = [1: "siyah", 2: "beyaz", 3: "kırmızı", 4: "turuncu", 5:"sarı" , 6: "yeşil", 7:"mavi" , 8:"mor"]
    let sizeNamesDict:[Int: String] = [1: "S", 2: "M", 3: "L"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.topView.layer.cornerRadius = 5
//        self.topView.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor
        self.actionView.addShadow(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0))
        self.locationManager.delegate = self
        
        let origImage = UIImage(systemName: "suit.heart.fill")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.likeButton.setImage(tintedImage, for: .normal)
        self.likeButton.imageView?.contentMode = .scaleAspectFit
        
        //willappeardaki servisin altına koy burayı
        let num = allColors.count
        let space: Int
        if num > 1 {
            space = ( 450 - (25 * num)) / (num-1) }
        else {
            space = 10
        }
        for item in allColors {
            let i = allColors.firstIndex(of: item)
            let x = (space * i!) + 50
            let y = 650
            self.colorButtons.append(makeColorButton(x: x, y: y))
            self.colorButtons[i!].backgroundColor = colorDict[i!+1]
            if existcolors.contains(item){
                self.colorButtons[i!].addTarget(self, action: #selector(self.existColorButtonPressed), for: .touchUpInside)
            }
            else{
                self.colorButtons[i!].addTarget(self, action: #selector(self.nonExistColorButtonPressed), for: .touchUpInside)
                if self.colorButtons[i!].backgroundColor != .black {
                    self.colorButtons[i!].setImage(UIImage(named: "x"), for: .normal)
                    
                }
                else{
                    self.colorButtons[i!].setImage(UIImage(named: "xwhite"), for: .normal)
                }
            }
        }
        
        let num2 = allSizes.count
        let space2: Int
        if num2 > 1 {
            space2 = ( 450 - (60 * num2)) / (num2-1) + 15 }
        else {
            space2 = 10
        }
        print("num: \(num2)")
        print("space: \(space2)")
        for item in allSizes {
            let i = allSizes.firstIndex(of: item)
            let x = (space2 * i!) + 50
            let y = 690
            self.sizeButtons.append(makeSizeButton(x: x, y: y))
            if existSizes.contains(item){
                self.sizeButtons[i!].addTarget(self, action: #selector(self.existSizeButtonPressed), for: .touchUpInside)
            }
            else{
                self.sizeButtons[i!].addTarget(self, action: #selector(self.nonExistSizeButtonPressed), for: .touchUpInside)
                self.sizeButtons[i!].setImage(UIImage(named: "x"), for: .normal)
            }
        }
    }
    
    func makeColorButton(x:Int, y:Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: x, y: y, width: 25, height: 25)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .red
        view.addSubview(button)
        return button
    }
    
    func makeSizeButton(x:Int, y:Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: x, y: y, width: 60, height: 30)
        button.layer.cornerRadius = 0.1 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .red
        view.addSubview(button)
        return button
    }
    
    @objc func existColorButtonPressed() {
        print("exist color button pressed")
    }
    
    @objc func nonExistColorButtonPressed() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "mapVC") as! MapVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func existSizeButtonPressed() {
        print("exist size button pressed")
    }
    
    @objc func nonExistSizeButtonPressed() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "mapVC") as! MapVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
                self?.colorLabel.text = "Renk: \(String(Int(self!.theProduct[0].color!)))"
                self?.sizeLabel.text = "Beden: \(String(Int(self!.theProduct[0].size!)))"
                self?.priceLabel.text = "Fiyat: \(String(Double(self!.theProduct[0].price!)))"
                self?.totallikesLabel.text = "Bu ürün \(String(Int(self!.theProduct[0].likeNumber!))) defa beğenildi"
                self?.totalscansLabel.text = "Bu ürün \(String(Int(self!.theProduct[0].scanNumber!))) defa tarandı"
                self?.nameLabel.text = String(self!.theProduct[0].name!)
                self?.productID = String(self!.theProduct[0].id!)
                self?.productTypeID = String(self!.theProduct[0].productTypeID!)
                self?.liked = Bool(self!.theProduct[0].liked!)
                if self?.liked == true {
                    self?.likeButton.tintColor = .systemRed
                }
                else{
                    self?.likeButton.tintColor = .black
                }
                for item in self!.theProduct[0].productImages! {
                    self?.imageUrlArray.append(String(item.path!))
                }
                self?.pageControl.numberOfPages = (self?.imageUrlArray.count)!
                DispatchQueue.main.async{
                    self?.photosCollectionView.reloadData()
                }
            }
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
        //POST
        if self.liked == false {
            
            NetworkManager.sendPostRequestwithAuth(urlStr: "http://192.168.1.155:62755/api/user/favorite/\(String(describing: self.productID))")
            { [weak self] (data, error) in
                if let error = error {
                    print("ERROR:\(error)")
                    return
                }
                if let data = data {
                    self!.liked = true
                    self!.likeButton.tintColor = .systemRed
                    
                }
            }
        }
        else{
            
            NetworkManager.sendDeleteFavoriteRequestwithAuth(urlStr: "http://192.168.1.155:62755/api/user/favorite/\(String(describing: self.productID))")
            { [weak self] (data, error) in
                if let error = error {
                    print("ERROR:\(error)")
                    return
                }
                if let data = data {
                    self!.liked = false
                    self!.likeButton.tintColor = .black
                }
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrlArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.photosCollectionViewIdentifier, for: indexPath) as! PhotosofProductCell
        var imageUrlString = "http://192.168.1.155/\(String(describing: self.imageUrlArray[indexPath.row]))"
        imageUrlString = imageUrlString.replacingOccurrences(of: "\\",
                                                             with: "/")
        
        let imageUrl = URL(string: imageUrlString)
        if let data = try? Data(contentsOf: imageUrl!) {
            // Create Image and Update Image View
            cell.imageView.image = UIImage(data: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.currentIndex = Int(scrollView.contentOffset.x / photosCollectionView.frame.size.width)
        pageControl.currentPage = currentIndex
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
