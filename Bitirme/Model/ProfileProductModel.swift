// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileProducts = try ProfileProducts(json)

import Foundation

// MARK: - ProfileProduct
struct ProfileProduct: Codable {
    let id, name: String?
    let color, size: Int?
    let productImage: ProductImage2?
}

// MARK: ProfileProduct convenience initializers and mutators

extension ProfileProduct {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(ProfileProduct.self, from: data)
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
        color: Int?? = nil,
        size: Int?? = nil,
        productImage: ProductImage2?? = nil
    ) -> ProfileProduct {
        return ProfileProduct(
            id: (id ?? self.id)!,
            name: name ?? self.name,
            color: color ?? self.color,
            size: size ?? self.size,
            productImage: productImage ?? self.productImage
        )
    }

    func jsonData2() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData2(), encoding: encoding)
    }
}

// MARK: - ProductImage
struct ProductImage2: Codable {
    let id: String?
    let sort: Int?
    let path: String?
}

// MARK: ProductImage convenience initializers and mutators

extension ProductImage2 {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(ProductImage2.self, from: data)
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
    ) -> ProductImage2 {
        return ProductImage2(
            id: id ?? self.id,
            sort: sort ?? self.sort,
            path: path ?? self.path
        )
    }

    func jsonData2() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData2(), encoding: encoding)
    }
}

typealias ProfileProducts = [ProfileProduct]

extension Array where Element == ProfileProducts.Element {
    init(data: Data) throws {
        self = try newJSONDecoder2().decode(ProfileProducts.self, from: data)
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

    func jsonData2() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData2(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder2() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder2() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
