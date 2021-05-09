//
//  ScanModel.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 9.05.2021.
//

import Foundation

struct ProductImages: Decodable {
    var id: String?
    var sort: Int?
    var path: String?
    
    /*    required init?(map: Map){
     }
     func mapping(map: Map) {
     id <- map["id"]
     sort <- map["sort"]
     path <- map["path"]
     }*/
}

struct ProductComments: Decodable {
    var productId: String?
    var username: String?
    var comment: String?
    var createdOn: String?
    
    /*    required init?(map: Map){
     }
     func mapping(map: Map) {
     productId <- map["productId"]
     username <- map["username"]
     comment <- map["comment"]
     createdOn <- map["createdOn"]
     }*/
}

struct Products: Decodable {
    var id: String?
    var userId: String?
    var productTypeId: String?
    var name: String?
    var stock: Int?
    var price: Int?
    var color: Int?
    var size: Int?
    var barcode: String?
    var productNo: String?
    var likesNumber: Int?
    var productImages: [ProductImages] = []
    var productComments: [ProductComments] = []
    
    /*    required init?(map: Map){
     }
     func mapping(map: Map) {
     id <- map["id"]
     userId <- map["userId"]
     productTypeId <- map["productTypeId"]
     name <- map["name"]
     stock <- map["stock"]
     price <- map["price"]
     color <- map["color"]
     size <- map["barcode"]
     barcode <- map["productNo"]
     productNo <- map["productNo"]
     likesNumber <- map["likesNumber"]
     productImages <- map["productImages"]
     productComments <- map["createdOn"]
     }*/
}

struct Scan: Decodable {
    var id: String?
    var name: String?
    var address: String?
    var products: [Products] = []
    
    /*    required init?(map: Map){
     }
     func mapping(map: Map) {
     id <- map["id"]
     name <- map["name"]
     name <- map["name"]
     address <- map["address"]
     products <- map["products"]
     }*/
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id", name = "name", address = "address", products
    }
}
