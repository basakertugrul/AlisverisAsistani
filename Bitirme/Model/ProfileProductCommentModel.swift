// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileProductComment = try ProfileProductComment(json)

import Foundation

// MARK: - ProfileProductCommentElement
struct ProfileProductCommentElement: Codable {
    let id, name: String?
    let color, size: Int?
    let ProductImage3: ProductImage3?
    let ProductComment3s: [ProductComment3]?
}

// MARK: ProfileProductCommentElement convenience initializers and mutators

extension ProfileProductCommentElement {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(ProfileProductCommentElement.self, from: data)
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
        ProductImage3: ProductImage3?? = nil,
        ProductComment3s: [ProductComment3]?? = nil
    ) -> ProfileProductCommentElement {
        return ProfileProductCommentElement(
            id: id ?? self.id,
            name: name ?? self.name,
            color: color ?? self.color,
            size: size ?? self.size,
            ProductImage3: ProductImage3 ?? self.ProductImage3,
            ProductComment3s: ProductComment3s ?? self.ProductComment3s
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
    let comment: String?
    let isAnonym: Bool?
    let createdOn: String?
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
        comment: String?? = nil,
        isAnonym: Bool?? = nil,
        createdOn: String?? = nil
    ) -> ProductComment3 {
        return ProductComment3(
            comment: comment ?? self.comment,
            isAnonym: isAnonym ?? self.isAnonym,
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

typealias ProfileProductComment3 = [ProfileProductCommentElement]

extension Array where Element == ProfileProductComment3.Element {
    init(data: Data) throws {
        self = try newJSONDecoder3().decode(ProfileProductComment3.self, from: data)
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
