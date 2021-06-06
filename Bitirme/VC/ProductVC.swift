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
    var productNo: String = ""
    var currentColor: Int = 0
    var currentSize: Int = 0
    
    
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
    var existcolors: [Int] = []
    var allSizes: [Int] = [1,2,3]
    var existSizes: [Int] = []
    
    var colorButtons: [UIButton] = []
    var sizeButtons: [UIButton] = []
    let colorDict: [Int: UIColor] = [1:UIColor.black.withAlphaComponent(0.7), 2:UIColor.white.withAlphaComponent(0.8), 3:UIColor(red: 0.698, green: 0.0784, blue: 0, alpha: 0.8), 4:UIColor(red: 0.898, green: 0.4784, blue: 0, alpha: 0.8), 5:UIColor(red: 0.898, green: 0.8392, blue: 0, alpha: 1.0), 6:UIColor(red: 0.4275, green: 0.7569, blue: 0, alpha: 0.8), 7:UIColor(red: 0, green: 0.5569, blue: 0.698, alpha: 0.8), 8:UIColor(red: 154/255, green: 0/255, blue: 154/255, alpha: 0.8)]
    
    let colorNamesDict:[Int: String] = [1: "Siyah", 2: "Beyaz", 3: "Kırmızı", 4: "Turuncu", 5:"Sarı" , 6: "Yeşil", 7:"Mavi" , 8:"Mor"]
    let sizeNamesDict:[Int: String] = [1: "S", 2: "M", 3: "L"]
    
    var comments: [ProductComment3] = []
    @IBOutlet weak var commentsCollectionView: UICollectionView!
    let commentsCollectionViewIdentifier = "PetitCommentsCell"
    @IBOutlet weak var left: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(self.barcodeNumber!)
        self.shadowButton(button: self.likeButton)
        self.shadowButton(button: self.seeAllCommentsButton)
        self.shadowButton(button: self.makeCommentButton)
        self.left.layer.cornerRadius = 5
        self.left.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        self.topView.layer.cornerRadius = 5
        //        self.topView.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor
        self.actionView.addShadow(shadowColor: .gray, offSet: CGSize(width: 2.6, height: 2.6), opacity: 0.8, shadowRadius: 5.0, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0))
        self.locationManager.delegate = self
        
        let origImage = UIImage(systemName: "suit.heart.fill")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        self.likeButton.setImage(tintedImage, for: .normal)
        self.likeButton.imageView?.contentMode = .scaleAspectFit
        print("BITTI")
        
    }
    func shadowButton(button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0.502, green: 0.7412, blue: 0.8667, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5   }
    
    func makeColorButton(x:Int, y:Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: x, y: y, width: 25, height: 25)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        view.addSubview(button)
        return button
    }
    
    func makeSizeButton(x:Int, y:Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: x, y: y, width: 60, height: 30)
        button.layer.cornerRadius = 0.1 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        view.addSubview(button)
        return button
    }
    
    @objc func existColorButtonPressed(sender: UIButton) {
        
    }
    
    @objc func nonExistColorButtonPressed(sender: UIButton) {
        print(self.productNo)
        print(sender.tag)
        print(self.currentSize)
        let params: [String: Any] = ["productNo": self.productNo ,
                                     "color": sender.tag,
                                     "size": self.currentSize]
        NetworkManager.sendPostRequestLoc(urlStr: "http://192.168.1.155:62755/api/store/map",
        parameters: params)
        { [weak self] (data, error) in
            if let error = error {
                print("Sign In Error:\(error)")
                return
            }
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "mapVC") as! MapVC
            for item in data! {
                vc.locationArray.append( [ item.latitude! , item.longtitude! ] )
                }
            vc.modalPresentationStyle = .fullScreen
            self!.present(vc, animated: true, completion: nil)
        }
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
                self!.storeLabel.text = String(self!.storeName)
                
                self!.productsArray = (dictionary.products)!
                for item in self!.productsArray {
                    let tempBarcode = item.barcode
                    if (String(tempBarcode!) == self?.barcodeNumber){
                        self?.theProduct.append(item)
                    }
                }
                
                //Servis gelince scan modeli ve burayı değiştir. Gelecek arrayleri ata existcolors ve sizes'a
                self!.existcolors = dictionary.colors!
                self!.existSizes = dictionary.sizes!
                let num = self!.allColors.count
                let space: Int
                if num > 1 {
                    space = ( 450 - (25 * num)) / (num-1) }
                else {
                    space = 10
                }
                for item in self!.allColors {
                    let i = self!.allColors.firstIndex(of: item)
                    let x = (space * i!) + 50
                    let y = 445
                    self!.colorButtons.append(self!.makeColorButton(x: x, y: y))
                    self!.colorButtons[i!].backgroundColor = self!.colorDict[i!+1]
                    self!.colorButtons[i!].tag = i!+1
                    if self!.existcolors.contains(item){
                        self!.colorButtons[i!].addTarget(self, action: #selector(self!.existColorButtonPressed), for: .touchUpInside)
                    }
                    else{
                        self!.colorButtons[i!].addTarget(self, action: #selector(self!.nonExistColorButtonPressed), for: .touchUpInside)
                        self!.colorButtons[i!].setImage(UIImage(named: "x"), for: .normal)
                    }
                }
                
                let num2 = self!.allSizes.count
                let space2: Int
                if num2 > 1 {
                    space2 = ( 350 - (60 * num2)) / (num2-1) + 15 }
                else {
                    space2 = 10
                }
                print("num: \(num2)")
                print("space: \(space2)")
                for item in self!.allSizes {
                    let i = self!.allSizes.firstIndex(of: item)
                    let x = (space2 * i!) + 50
                    let y = 478
                    self!.sizeButtons.append(self!.makeSizeButton(x: x, y: y))
                    if self!.existSizes.contains(item){
                        self!.sizeButtons[i!].addTarget(self, action: #selector(self!.existSizeButtonPressed), for: .touchUpInside)
                    }
                    else{
                        self!.sizeButtons[i!].addTarget(self, action: #selector(self!.nonExistSizeButtonPressed), for: .touchUpInside)
                        self!.sizeButtons[i!].setImage(UIImage(named: "inceX"), for: .normal)
                    }
                    self!.sizeButtons[i!].setTitle(String(self!.sizeNamesDict[i!+1]!), for: .normal)
                }
                if let color = self?.colorNamesDict[Int((self!.theProduct[0].color!))] {
                    self?.colorLabel.text = "Renk: \(color)"
                }
                if let size = self?.sizeNamesDict[Int((self!.theProduct[0].size!))] {
                    self?.sizeLabel.text = "Beden: \(size)"
                }
                self?.priceLabel.text = "Fiyat: \(String(Double(self!.theProduct[0].price!)))"
                self?.totallikesLabel.text = "Bu ürün \(String(Int(self!.theProduct[0].likeNumber!))) defa beğenildi"
                self?.totalscansLabel.text = "Bu ürün \(String(Int(self!.theProduct[0].scanNumber!))) defa tarandı"
                self?.nameLabel.text = String(self!.theProduct[0].name!)
                self?.productID = String(self!.theProduct[0].id!)
                self?.productNo = String(self!.theProduct[0].productNo!)
                self?.productTypeID = String(self!.theProduct[0].productTypeID!)
                self?.currentSize = Int(self!.theProduct[0].size!)
                self?.currentColor = Int(self!.theProduct[0].color!)
                self?.liked = Bool(self!.theProduct[0].liked!)
                if self?.liked == true {
                    self?.likeButton.tintColor = UIColor(red: 158/255, green: 0/255, blue: 0/255, alpha: 1.0)
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
                if let array = self!.theProduct[0].productComments{
                    self?.comments = array
                    DispatchQueue.main.async{
                        self?.commentsCollectionView.reloadData()
                    }
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
        vc.comments = self.comments
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
                    self!.likeButton.tintColor = UIColor(red: 158/255, green: 0/255, blue: 0/255, alpha: 1.0)
                }
            }
        }
        else {
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
        else {
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
        if collectionView == self.photosCollectionView {
            return self.imageUrlArray.count
        }
        else {
//            return self.comments.count
            if self.theProduct.isEmpty {
                return 0
            }
            else{
                return 5
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.photosCollectionView {
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
        else {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: self.commentsCollectionViewIdentifier, for: indexPath) as! PetitCommentsCell
            self.cardShadow(cell: cellA)
            cellA.label.text = self.theProduct[0].name
            cellA.label.textColor = .black
            cellA.detail.text = self.comments[indexPath.row].comment
            cellA.detail.textColor = .black
            cellA.seconddetail.text = self.comments[indexPath.row].username
            cellA.seconddetail.textColor = .black
            var imageUrlString = "http://192.168.1.155/\(String(describing: self.imageUrlArray[indexPath.row % (self.imageUrlArray.count)]))"
            imageUrlString = imageUrlString.replacingOccurrences(of: "\\",
                                                                 with: "/")
            let imageUrl = URL(string: imageUrlString)
            if let data = try? Data(contentsOf: imageUrl!) {
                // Create Image and Update Image View
                cellA.imageView.image = UIImage(data: data)
            }
            return cellA
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.photosCollectionView {
            self.currentIndex = Int(scrollView.contentOffset.x / photosCollectionView.frame.size.width)
            pageControl.currentPage = currentIndex
        }
        else {
            //code for this scrollView2
        }
        
    }
    
    func cardShadow(cell: UICollectionViewCell){
        //        This creates the shadows and modifies the cards a little bit
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15.0
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
