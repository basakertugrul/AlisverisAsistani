//
//  SeeAllCommentsVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit

class SeeAllCommentsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var producTitle: UILabel!
    @IBOutlet weak var CommentsofProductsCollectionView: UICollectionView!
    let favoritesCollectionViewIdentifier = "CommentsofProductCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.CommentsofProductsCollectionView.layer.cornerRadius = 10
        self.CommentsofProductsCollectionView.layer.masksToBounds = true
        
        self.CommentsofProductsCollectionView?.delegate = self
        self.CommentsofProductsCollectionView?.dataSource = self
        self.view.addSubview(self.CommentsofProductsCollectionView)
        
    }
    func cardShadow(cell: UICollectionViewCell){
        //This creates the shadows and modifies the cards a little bit
//        cell.backgroundColor = UIColor(red: 0.957, green: 0.918, blue: 0.902, alpha: 1.0)
//        cell.backgroundColor = .white
        cell.backgroundColor = UIColor(red: 0.184, green: 0.314, blue: 0.380, alpha: 1)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.favoritesCollectionViewIdentifier, for: indexPath) as! CommentsofProductCollectionCell
        self.cardShadow(cell: cell)
        cell.label.text = "commentttingggjbfgd"
        return cell
    }
    
    @IBAction func goBackButtonPressed(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "productVC") as! ProductVC
        vc.modalPresentationStyle = .fullScreen
//        vc.barcodeNumber = self.barcodeNumber
        present(vc, animated: true, completion: nil)
    }
}
