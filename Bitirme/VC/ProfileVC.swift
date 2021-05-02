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
        
        // Do any additional setup after loading the view.
        signInButton?.layer.cornerRadius = 0.05 * signInButton.bounds.size.width
        registerButton?.layer.cornerRadius = 0.05 * registerButton.bounds.size.width
        topView?.layer.cornerRadius = 5
        topView?.layer.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1.0).cgColor
        
        self.favoritesCollectionView?.register(FavoritesCollectionCell.self, forCellWithReuseIdentifier: favoritesCollectionViewIdentifier)
        self.scannedCollectionView?.register(ScannedCollectionCell.self, forCellWithReuseIdentifier: scannedCollectionViewIdentifier)
        self.commentedCollectionView?.register(CommentedCollectionCell.self, forCellWithReuseIdentifier: commentedCollectionViewIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (UserDefaults.standard.string(forKey: "token") != nil){
            
            let myView = UIView(frame: CGRect(x: 0, y: 170, width: 500, height: 630))
            myView.backgroundColor = UIColor(red: 0.957, green: 0.918, blue: 0.902, alpha: 1.0) //açık pembe
            let gif = UIImage.gifImageWithName("funny")
            let imageView = UIImageView(image: gif)
            imageView.frame = CGRect(x: 10, y: 175, width: 400, height: 600)
            view.addSubview(myView)
            view.addSubview(imageView)
        }
        else{
            setUpFavorites()
            favoritesCollectionView?.delegate = self
            scannedCollectionView?.delegate = self
            commentedCollectionView?.delegate = self
            
            favoritesCollectionView?.dataSource = self
            scannedCollectionView?.dataSource = self
            commentedCollectionView?.dataSource = self
            
            if favoritesCollectionView != nil {
                self.view.addSubview(favoritesCollectionView)
            }
            if scannedCollectionView != nil {
                self.view.addSubview(scannedCollectionView)
            }
            if commentedCollectionView != nil {
                self.view.addSubview(commentedCollectionView)
            }
            //            self.helloLabel.text = "Hello \(UserDefaults.standard.string(forKey: "username"))!"
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "signInVC") as! SignInVC
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
    }
    
    
    func setUpFavorites(){
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.favoritesCollectionView {
            return 100
        }
        else if collectionView == self.commentedCollectionView {
            return 150
        }
        else{
            return 599
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.favoritesCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: self.favoritesCollectionViewIdentifier, for: indexPath) as! FavoritesCollectionCell
            self.cardShadow(cell: cellA)
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
        cell.layer.cornerRadius = 8
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 8.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    
    
    
    
    
    
    
    
    
}

