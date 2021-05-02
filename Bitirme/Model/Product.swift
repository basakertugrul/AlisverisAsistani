//
//  Product.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 1.05.2021.
//

import Foundation


class Product {
    var id: String
    var name: String
    var imageURL: NSURL?

    init(id: String, name: String, email: String, imageURL: NSURL?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}
