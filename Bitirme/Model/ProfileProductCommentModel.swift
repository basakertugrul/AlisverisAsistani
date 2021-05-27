// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileProductComment = try ProfileProductComment(json)

import Foundation

// MARK: - ProfileProductCommentElement
struct ProfileProductCommentElement: Codable {
    let id, name: String?
    let color, size: Int?
    let productImage: ProductImage?
    let productComments: [ProductComment]?
}

// MARK: ProfileProductCommentElement convenience initializers and mutators

extension ProfileProductCommentElement {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProfileProductCommentElement.self, from: data)
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
        productImage: ProductImage?? = nil,
        productComments: [ProductComment]?? = nil
    ) -> ProfileProductCommentElement {
        return ProfileProductCommentElement(
            id: id ?? self.id,
            name: name ?? self.name,
            color: color ?? self.color,
            size: size ?? self.size,
            productImage: productImage ?? self.productImage,
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
    let comment: String?
    let isAnonym: Bool?
    let createdOn: String?
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
        comment: String?? = nil,
        isAnonym: Bool?? = nil,
        createdOn: String?? = nil
    ) -> ProductComment {
        return ProductComment(
            comment: comment ?? self.comment,
            isAnonym: isAnonym ?? self.isAnonym,
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

typealias ProfileProductComment = [ProfileProductCommentElement]

extension Array where Element == ProfileProductComment.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ProfileProductComment.self, from: data)
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
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
