// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scan = try Scan(json)

import Foundation

// MARK: - Scan
struct Scan: Codable {
    let id, name: String?
    let address: JSONNull?
    let products: [ScanProduct]?
}

// MARK: Scan convenience initializers and mutators

extension Scan {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(Scan.self, from: data)
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
        products: [ScanProduct]?? = nil
    ) -> Scan {
        return Scan(
            id: id ?? self.id,
            name: name ?? self.name,
            address: address ?? self.address,
            products: products ?? self.products
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder3().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ScanProduct
struct ScanProduct: Codable {
    let id, userID, productTypeID, name: String?
    let stock: Int?
    let price: Double?
    let color, size: Int?
    let barcode, productNo: String?
    let likeNumber, scanNumber: Int?
    let liked: String?
    let productImages: [ProductImage3]?
    let favorites: [Favorite]?
    let productComments: [ProductComment3]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case productTypeID = "productTypeId"
        case name, stock, price, color, size, barcode, productNo, likeNumber, scanNumber, liked, productImages, favorites, productComments
    }
}

// MARK: ScanProduct convenience initializers and mutators

extension ScanProduct {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(ScanProduct.self, from: data)
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
        likeNumber: Int?? = nil,
        scanNumber: Int?? = nil,
        liked: String?? = nil,
        productImages: [ProductImage3]?? = nil,
        favorites: [Favorite]?? = nil,
        productComments: [ProductComment3]?? = nil
    ) -> ScanProduct {
        return ScanProduct(
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
            likeNumber: likeNumber ?? self.likeNumber,
            scanNumber: scanNumber ?? self.scanNumber,
            liked: liked ?? self.liked,
            productImages: productImages ?? self.productImages,
            favorites: favorites ?? self.favorites,
            productComments: productComments ?? self.productComments
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder3().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Favorite
struct Favorite: Codable {
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
    }
}

// MARK: Favorite convenience initializers and mutators

extension Favorite {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(Favorite.self, from: data)
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
        userID: String?? = nil
    ) -> Favorite {
        return Favorite(
            userID: userID ?? self.userID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder3().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProductComment3
struct ProductComment3: Codable {
    let productID, username, comment, createdOn: String?

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case username, comment, createdOn
    }
}

// MARK: ProductComment3 convenience initializers and mutators

extension ProductComment3 {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(ProductComment3.self, from: data)
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
    ) -> ProductComment3 {
        return ProductComment3(
            productID: productID ?? self.productID,
            username: username ?? self.username,
            comment: comment ?? self.comment,
            createdOn: createdOn ?? self.createdOn
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder3().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - ProductImage3
struct ProductImage3: Codable {
    let id: String?
    let sort: Int?
    let path: String?
}

// MARK: ProductImage3 convenience initializers and mutators

extension ProductImage3 {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(ProductImage3.self, from: data)
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
    ) -> ProductImage3 {
        return ProductImage3(
            id: id ?? self.id,
            sort: sort ?? self.sort,
            path: path ?? self.path
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder3().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder3() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder3() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
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
