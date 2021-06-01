//
//  ProfileVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//


import UIKit
import SwiftKeychainWrapper

class ProfileVC:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var leftFavoritesButton: UIView!
    @IBOutlet weak var leftScannedButton: UIView!
    @IBOutlet weak var leftcommentedButton: UIView!
    
    var favoritesArray = [ProfileProduct]()
    var scannedArray = [ProfileProduct]()
    var commentedArray = [ProfileProductCommentElement]()
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    @IBOutlet weak var scannedCollectionView: UICollectionView!
    @IBOutlet weak var commentedCollectionView: UICollectionView!
    let favoritesCollectionViewIdentifier = "FavoritesCollectionCell"
    let scannedCollectionViewIdentifier = "ScannedCollectionCell"
    let commentedCollectionViewIdentifier = "CommentedCollectionCell"
    
    let colorNamesDict:[Int: String] = [1: "Siyah", 2: "Beyaz", 3: "Kırmızı", 4: "Turuncu", 5:"Sarı" , 6: "Yeşil", 7:"Mavi" , 8:"Mor"]
    let sizeNamesDict:[Int: String] = [1: "S", 2: "M", 3: "L"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.signInButton?.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        self.registerButton?.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        self.signInButton?.layer.cornerRadius = 0.05 * self.signInButton.bounds.size.width
        self.registerButton?.layer.cornerRadius = 0.05 * self.registerButton.bounds.size.width
        self.topView?.clipsToBounds = true
        self.topView?.layer.cornerRadius = 5
        self.topView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.topView?.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor // koyu petrol
        self.signInButton?.backgroundColor = UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0)
        self.registerButton?.backgroundColor = UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0)
        self.leftScannedButton?.layer.cornerRadius = 1
        self.leftFavoritesButton?.layer.cornerRadius = 1
        self.leftcommentedButton?.layer.cornerRadius = 1
        if (KeychainWrapper.standard.string(forKey: "username") == nil){
            //            pushSignInVC()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if KeychainWrapper.standard.string(forKey: "username") != nil {
            
            let username = String(KeychainWrapper.standard.string(forKey: "username")!)
            let password = String(KeychainWrapper.standard.string(forKey: "password")!)
            
            let params: [String: Any] = ["username": username,
                                         "password": password]
            let signUrlStr = "http://192.168.1.155:62755/api/auth/login"
            NetworkManager.sendPostRequest(urlStr: signUrlStr,
                                           parameters: params)
            { [weak self] (data, error) in
                if let error = error {
                    print("Sign In Error:\(error)")
                    return
                }
                self!.userSignedIn(data: data, username: username, password: password)
                self!.setUpFavorites()
                self!.setUpScanned()
                self!.setUpCommented()
            }
        }
        
        if (KeychainWrapper.standard.string(forKey: "token") == nil){
            let myView = UIView(frame: CGRect(x: 0, y: 170, width: 500, height: 630))
            myView.backgroundColor = UIColor(red: 0.918, green: 0.827, blue: 0.796, alpha: 1.0) //açık pembe
            let gif = UIImage.gifImageWithName("funny")
            let imageView = UIImageView(image: gif)
            imageView.frame = CGRect(x: 0, y: 175, width: 450, height: 660)
            view.addSubview(myView)
            view.addSubview(imageView)
            
            self.registerButton?.isEnabled = true
            self.registerButton?.backgroundColor = UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0) //açık mavi
            self.registerButton?.setTitle("Register", for: .normal)
            self.signInButton?.setTitle("Sign In", for: .normal)
            self.helloLabel?.text = "Hello stranger!"
        }
        else{
            self.helloLabel?.text = "Hello \(KeychainWrapper.standard.string(forKey: "username")!)!"
            self.registerButton?.isEnabled = false
            self.registerButton?.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0)
            self.registerButton?.setTitle("", for: .normal)
            self.signInButton?.setTitle("Sign Out", for: .normal)
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if (KeychainWrapper.standard.string(forKey: "token") == nil){
            self.pushSignInVC()
        }
        else {
            let _: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
            let _: Bool = KeychainWrapper.standard.removeObject(forKey: "username")
            let _: Bool = KeychainWrapper.standard.removeObject(forKey: "expiration")
            let _: Bool = KeychainWrapper.standard.removeObject(forKey: "password")
            
            self.viewWillAppear(true)
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        self.pushRegisterVC()
    }
    
    func setUpFavorites(){
        NetworkManager.sendGetRequestwithAuth(urlStr: "http://192.168.1.155:62755/api/user/favorite")
        { [weak self] (data, error) in
            if let error = error {
                print("ERROR:\(error)")
                return
            }
            if let array = data {
                self?.favoritesArray = array
                DispatchQueue.main.async{
                    self?.favoritesCollectionView.reloadData()
                }
            }
        }
    }
    
    func setUpScanned(){
        NetworkManager.sendGetRequestwithAuth(urlStr: "http://192.168.1.155:62755/api/user/scan")
        { [weak self] (data, error) in
            if let error = error {
                print("ERROR:\(error)")
                return
            }
            if let array = data {
                self?.scannedArray = array
                DispatchQueue.main.async{
                    self?.scannedCollectionView.reloadData()
                }
            }
        }
    }
    
    func setUpCommented(){
        NetworkManager.sendCommentGetRequestwithAuth(urlStr: "http://192.168.1.155:62755/api/user/comment")
        { [weak self] (data, error) in
            if let error = error {
                print("ERROR:\(error)")
                return
            }
            if let array = data {
                self?.commentedArray = array
                DispatchQueue.main.async{
                    self?.commentedCollectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favoritesCollectionView {
            return self.favoritesArray.count
        }
        else if collectionView == self.commentedCollectionView {
            return self.commentedArray.count
        }
        else{
            return self.scannedArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.favoritesCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: self.favoritesCollectionViewIdentifier, for: indexPath) as! FavoritesCollectionCell
            self.cardShadow(cell: cellA)
            cellA.label.text = favoritesArray[indexPath.row].name
            cellA.label.textColor = .black
            cellA.detail.text = self.colorNamesDict[favoritesArray[indexPath.row].color!]
            cellA.detail.textColor = .black
            cellA.seconddetail.text = self.sizeNamesDict[favoritesArray[indexPath.row].size!]
            cellA.seconddetail.textColor = .black
            if ((favoritesArray[indexPath.row].productImage?.path) != nil) {
                let path = String(describing: (favoritesArray[indexPath.row].productImage?.path!)!) //OPTIONI YOK ETTİM)
                var imageUrlString = "http://192.168.1.155/\(path)"
                imageUrlString = imageUrlString.replacingOccurrences(of: "\\",
                                                                     with: "/")
                let imageUrl = URL(string: imageUrlString)
                if let data = try? Data(contentsOf: imageUrl!) {
                    // Create Image and Update Image View
                    cellA.imageView.image = UIImage(data: data)
                }
            }
            return cellA
        }
        else if collectionView == self.scannedCollectionView {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: self.scannedCollectionViewIdentifier, for: indexPath) as! ScannedCollectionCell
            self.cardShadow(cell: cellB)
            cellB.label.text = self.scannedArray[indexPath.row].name
            cellB.label.textColor = .black
            cellB.detail.text = self.colorNamesDict[scannedArray[indexPath.row].color!]
            cellB.detail.textColor = .black
            cellB.seconddetail.text = self.sizeNamesDict[scannedArray[indexPath.row].size!]
            cellB.seconddetail.textColor = .black
            if ((scannedArray[indexPath.row].productImage?.path) != nil) {
                let path = String(describing: (scannedArray[indexPath.row].productImage?.path!)!) //OPTIONI YOK ETTİM)
                var imageUrlString = "http://192.168.1.155/\(path)"
                imageUrlString = imageUrlString.replacingOccurrences(of: "\\",
                                                                     with: "/")
                let imageUrl = URL(string: imageUrlString)
                if let data = try? Data(contentsOf: imageUrl!) {
                    // Create Image and Update Image View
                    cellB.imageView.image = UIImage(data: data)
                }
            }
            return cellB
        }
        else{
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: self.commentedCollectionViewIdentifier, for: indexPath) as! CommentedCollectionCell
            self.cardShadow(cell: cellC)
            cellC.label.text = commentedArray[indexPath.row].name
            cellC.label.textColor = .black
            if let array =  commentedArray[indexPath.row].productComments{
                cellC.detail.text = String(describing: array[0].comment!)
                cellC.detail.textColor = .black
            }
            
            cellC.seconddetail.text = "\(String(describing: self.colorNamesDict[commentedArray[indexPath.row].color!]!)), \(String(describing: self.sizeNamesDict[commentedArray[indexPath.row].size!]!))"
            cellC.seconddetail.textColor = .black
            
            if ((commentedArray[indexPath.row].productImage?.path) != nil) {
                let path = String(describing: (commentedArray[indexPath.row].productImage?.path!)!) //OPTIONI YOK ETTİM)
                var imageUrlString = "http://192.168.1.155/\(path)"
                imageUrlString = imageUrlString.replacingOccurrences(of: "\\",
                                                                     with: "/")
                let imageUrl = URL(string: imageUrlString)
                if let data = try? Data(contentsOf: imageUrl!) {
                    // Create Image and Update Image View
                    cellC.imageView.image = UIImage(data: data)
                }
            }
            return cellC
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
    
    func pushSignInVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "signInVC") as! SignInVC
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
    
    func pushRegisterVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterVC
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
    func userSignedIn(data: [String : Any]?, username: String, password: String)  {
        if let token = data!["token"] as? String{
            if let expiration = data!["expiration"] as? String{
                let _: Bool = KeychainWrapper.standard.set(String(token), forKey: "token")
                let _: Bool = KeychainWrapper.standard.set(String(username), forKey: "username")
                let _: Bool = KeychainWrapper.standard.set(String(expiration), forKey: "expiration")
                let _: Bool = KeychainWrapper.standard.set(String(password), forKey: "password")
            }
        }
    }
}

//SUNA BI BAK KUCUK RESIMLER ICIN
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}

extension UIImage {
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        self.init(data: imageData)
    }
}
