//
//  FavoritesCollectionCell.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 1.05.2021.
//

import UIKit

class FavoritesCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UILabel!
}

class ScannedCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UILabel!
}

class CommentedCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var comment: UILabel!
}


