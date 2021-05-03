//
//  ProfileVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//


import UIKit

class ProfileVC:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var helloLabel: UILabel!
    
    var favoritesArray = [Product]()
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    @IBOutlet weak var scannedCollectionView: UICollectionView!
    @IBOutlet weak var commentedCollectionView: UICollectionView!
    let favoritesCollectionViewIdentifier = "FavoritesCollectionCell"
    let scannedCollectionViewIdentifier = "ScannedCollectionCell"
    let commentedCollectionViewIdentifier = "CommentedCollectionCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //who am i servisi döndür auth yoksa veya varsayı bekle array dolsun
        // Do any additional setup after loading the view.
        self.signInButton?.layer.cornerRadius = 0.05 * self.signInButton.bounds.size.width
        self.registerButton?.layer.cornerRadius = 0.05 * self.registerButton.bounds.size.width
        self.topView?.layer.cornerRadius = 5
        self.topView?.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor
        
        self.favoritesCollectionView?.delegate = self
        self.scannedCollectionView?.delegate = self
        self.commentedCollectionView?.delegate = self
        
        self.favoritesCollectionView?.dataSource = self
        self.scannedCollectionView?.dataSource = self
        self.commentedCollectionView?.dataSource = self
        
        self.view.addSubview(self.favoritesCollectionView)
        self.view.addSubview(self.scannedCollectionView)
        self.view.addSubview(self.commentedCollectionView)
        
//        signInButton.removeFromSuperview()
//        registerButton.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserDefaults.standard.string(forKey: "token") == nil){
            //            let myView = UIView(frame: CGRect(x: 0, y: 170, width: 500, height: 630))
            //            myView.backgroundColor = UIColor(red: 0.957, green: 0.918, blue: 0.902, alpha: 1.0) //açık pembe
            //            let gif = UIImage.gifImageWithName("funny")
            //            let imageView = UIImageView(image: gif)
            //            imageView.frame = CGRect(x: 0, y: 175, width: 450, height: 660)
            //            view.addSubview(myView)
            //            view.addSubview(imageView)
            //            pushSignInVC()
        }
        else{
            setUpFavorites()
            //            self.helloLabel.text = "Hello \(UserDefaults.standard.string(forKey: "username"))!"
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        pushSignInVC()
    }
    
    @IBAction func registerPressed(_ sender: Any) {
    }
    
    
    func setUpFavorites(){
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favoritesCollectionView {
            return 12
        }
        else if collectionView == self.commentedCollectionView {
            return 22
        }
        else{
            return 43
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.favoritesCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: self.favoritesCollectionViewIdentifier, for: indexPath) as! FavoritesCollectionCell
            self.cardShadow(cell: cellA)
            cellA.label.text = "commentttingggjbfgd"
            return cellA
        }
        else if collectionView == self.scannedCollectionView {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: self.scannedCollectionViewIdentifier, for: indexPath) as! ScannedCollectionCell
            self.cardShadow(cell: cellB)
            return cellB
        }
        else{
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: self.commentedCollectionViewIdentifier, for: indexPath) as! CommentedCollectionCell
            self.cardShadow(cell: cellC)
            return cellC
        }
    }
    
    func cardShadow(cell: UICollectionViewCell){
        //This creates the shadows and modifies the cards a little bit
        cell.backgroundColor = UIColor(red: 0.957, green: 0.918, blue: 0.902, alpha: 1.0)
        //cell.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 15.0
    }
    
    func pushSignInVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "signInVC") as! SignInVC
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
}

