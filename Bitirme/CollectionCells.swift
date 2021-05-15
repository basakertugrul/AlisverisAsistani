//
//  CollectionCells.swift.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 1.05.2021.
//

import UIKit

class FavoritesCollectionCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var seconddetail: UILabel!
}

class ScannedCollectionCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var seconddetail: UILabel!
}

class CommentedCollectionCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var seconddetail: UILabel!
}

class CommentsofProductCollectionCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var detail: UILabel!
}

class PhotosofProductCell: UICollectionViewCell{
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
}

