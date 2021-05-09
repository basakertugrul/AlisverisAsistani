//
//  Services.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 27.04.2021.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


enum HTTPRequestMethod {
    case get
    case post
    case delete
    case put
    
    var afMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        case .put:
            return .put
        }
    }
}


typealias RequestCompletionBlock = (_ data: [String: Any]?, _ error: String?) -> ()


struct NetworkManager {
    static func sendPostRequest(urlStr: String,
                                parameters: [String: Any],
                                completion: @escaping RequestCompletionBlock) {
        
        AF.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .failure(let error):
                    print(error)
                    completion(nil, error.localizedDescription)
                case .success(let responseObject):
                    print(responseObject)
                    completion(responseObject as? [String : Any], nil)
                }
            }
    }
    
    static func sendGetRequest(urlStr: String,
                               completion: @escaping RequestCompletionBlock) {
        AF.request(urlStr, method: .get, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    completion(nil, error.localizedDescription)
                case .success(let responseObject):
                    completion(responseObject as? [String : Any], nil)
                }
            }
    }
    
    static func sendScanRequest(urlStr: String,
                               completion: @escaping RequestCompletionBlock) {
        AF.request(urlStr, method: .get, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    print(error)
                    completion(nil, error.localizedDescription)
                case .success(let responseObject):
                    completion(responseObject as? [String : Any], nil)
                }
            }
    }
}