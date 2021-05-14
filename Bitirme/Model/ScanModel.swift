// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scan = try Scan(json)

import Foundation

// MARK: - Scan
struct Scan: Codable {
    let id, name: String?
    let address: JSONNull?
    let products: [Products]?
}

// MARK: Scan convenience initializers and mutators

extension Scan {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Scan.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        name: String?? = nil,
        address: JSONNull?? = nil,
        products: [Products]?? = nil
    ) -> Scan {
        return Scan(
            id: id ?? self.id,
            name: name ?? self.name,
            address: address ?? self.address,
            products: products ?? self.products
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Products
struct Products: Codable {
    let id, userID, productTypeID, name: String?
    let stock: Int?
    let price: Double?
    let color, size: Int?
    let barcode, productNo: String?
    let likesNumber: Int?
    let productImages: [ProductImage]?
    let productComments: [ProductComment]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case productTypeID = "productTypeId"
        case name, stock, price, color, size, barcode, productNo, likesNumber, productImages, productComments
    }
}

// MARK: Products convenience initializers and mutators

extension Products {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Products.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: String?? = nil,
        userID: String?? = nil,
        productTypeID: String?? = nil,
        name: String?? = nil,
        stock: Int?? = nil,
        price: Double?? = nil,
        color: Int?? = nil,
        size: Int?? = nil,
        barcode: String?? = nil,
        productNo: String?? = nil,
        likesNumber: Int?? = nil,
        productImages: [ProductImage]?? = nil,
        productComments: [ProductComment]?? = nil
    ) -> Products {
        return Products(
            id: id ?? self.id,
            userID: userID ?? self.userID,
            productTypeID: productTypeID ?? self.productTypeID,
            name: name ?? self.name,
            stock: stock ?? self.stock,
            price: price ?? self.price,
            color: color ?? self.color,
            size: size ?? self.size,
            barcode: barcode ?? self.barcode,
            productNo: productNo ?? self.productNo,
            likesNumber: likesNumber ?? self.likesNumber,
            productImages: productImages ?? self.productImages,
            productComments: productComments ?? self.productComments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProductComment
struct ProductComment: Codable {
    let productID, username, comment, createdOn: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case username, comment, createdOn
    }
}

// MARK: ProductComment convenience initializers and mutators

extension ProductComment {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProductComment.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        productID: String?? = nil,
        username: String?? = nil,
        comment: String?? = nil,
        createdOn: String?? = nil
    ) -> ProductComment {
        return ProductComment(
            productID: productID ?? self.productID,
            username: username ?? self.username,
            comment: comment ?? self.comment,
            createdOn: createdOn ?? self.createdOn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProductImage
struct ProductImage: Codable {
    let id: String?
    let sort: Int?
    let path: String?
}

// MARK: ProductImage convenience initializers and mutators

extension ProductImage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProductImage.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        sort: Int?? = nil,
        path: String?? = nil
    ) -> ProductImage {
        return ProductImage(
            id: id ?? self.id,
            sort: sort ?? self.sort,
            path: path ?? self.path
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
