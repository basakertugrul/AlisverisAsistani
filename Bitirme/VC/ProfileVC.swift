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
    var commentedArray = ProfileProductComment3()
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    @IBOutlet weak var scannedCollectionView: UICollectionView!
    @IBOutlet weak var commentedCollectionView: UICollectionView!
    let favoritesCollectionViewIdentifier = "FavoritesCollectionCell"
    let scannedCollectionViewIdentifier = "ScannedCollectionCell"
    let commentedCollectionViewIdentifier = "CommentedCollectionCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.signInButton?.layer.cornerRadius = 0.05 * self.signInButton.bounds.size.width
        self.registerButton?.layer.cornerRadius = 0.05 * self.registerButton.bounds.size.width
        self.topView?.layer.cornerRadius = 5
        self.topView?.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor // koyu petrol
        self.signInButton?.backgroundColor = UIColor(red: 0.741, green: 0.780, blue: 0.788, alpha: 1.0)
        self.leftScannedButton?.layer.cornerRadius = 15
        self.leftFavoritesButton?.layer.cornerRadius = 15
        self.leftcommentedButton?.layer.cornerRadius = 15
        if (KeychainWrapper.standard.string(forKey: "username") == nil){
            //            pushSignInVC()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpFavorites()
        self.setUpScanned()
        self.setUpCommented()
        
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
            if ((scannedArray[indexPath.row].productImage?.path) != nil) {
                let path = String(describing: (scannedArray[indexPath.row].productImage?.path!)!)} //OPTIONI YOK ETTİM)
            cellA.detail.text = String(describing: (favoritesArray[indexPath.row].id)!)
            return cellA
        }
        else if collectionView == self.scannedCollectionView {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: self.scannedCollectionViewIdentifier, for: indexPath) as! ScannedCollectionCell
            self.cardShadow(cell: cellB)
            cellB.label.text = scannedArray[indexPath.row].name
            cellB.label.textColor = .black
            if ((scannedArray[indexPath.row].productImage?.path) != nil) {
                let path = String(describing: (scannedArray[indexPath.row].productImage?.path!)!)} //OPTIONI YOK ETTİM)
            cellB.detail.text = String(describing: indexPath.row)
            return cellB
        }
        else{
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: self.commentedCollectionViewIdentifier, for: indexPath) as! CommentedCollectionCell
            self.cardShadow(cell: cellC)
            cellC.label.text = commentedArray[indexPath.row].name
            cellC.label.textColor = .black
            if ((scannedArray[indexPath.row].productImage?.path) != nil) {
                let path = String(describing: (scannedArray[indexPath.row].productImage?.path!)!)} //OPTIONI YOK ETTİM)
            cellC.detail.text = String(describing: indexPath.row)
            
//            let comments = commentedArray[indexPath.row]
//            cellC.detail.text = comments![0].comment
//            cellC.seconddetail.text = comments![0].createdOn
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
}
