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
import SwiftKeychainWrapper

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
typealias ScanRequestCompletionBlock = (_ data: Scan?, _ error: String?) -> ()
typealias GetRequestCompletionBlock = (_ data: [ProfileProduct]?, _ error: String?) -> ()
typealias CommentGetRequestCompletionBlock = (_ data: ProfileProductComment?, _ error: String?) -> ()
typealias PostRequestCompletionBlock = (_ data: String?, _ error: String?) -> ()


struct NetworkManager {
    static func sendPostRequest(urlStr: String,
                                parameters: [String: Any],
                                completion: @escaping RequestCompletionBlock) {
        
        AF.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                case .success(let responseObject):
                    completion(responseObject as? [String : Any], nil)
                }
            }
    }
    
    static func sendGetRequestwithAuth(urlStr: String,
                                       completion: @escaping GetRequestCompletionBlock) {
        let stringToken = String(describing: KeychainWrapper.standard.string(forKey: "token") ?? "" )
        let headers : HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(stringToken)"]
        
        AF.request(urlStr, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let jsonString = String(data: response.data!, encoding: .utf8)
                        let profileProducts = try ProfileProducts(jsonString!)
                        completion(profileProducts, nil )
                    }
                    catch let e {
                        completion(nil, e.localizedDescription)
                    }
                    
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
    
    static func sendPostRequestwithAuth(urlStr: String,
                                        completion: @escaping PostRequestCompletionBlock) {
        let stringToken = String(describing: KeychainWrapper.standard.string(forKey: "token") ?? "" )
        let headers : HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(stringToken)"]
        
        AF.request(urlStr, method: .post, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let jsonString = String(data: response.data!, encoding: .utf8)
                    completion(jsonString, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
    
    static func sendDeleteFavoriteRequestwithAuth(urlStr: String,
                                                  completion: @escaping PostRequestCompletionBlock) {
        let stringToken = String(describing: KeychainWrapper.standard.string(forKey: "token") ?? "" )
        let headers : HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(stringToken)"]
        
        AF.request(urlStr, method: .delete, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let jsonString = String(data: response.data!, encoding: .utf8)
                    completion(jsonString, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
    
    static func sendCommentGetRequestwithAuth(urlStr: String,
                                              completion: @escaping CommentGetRequestCompletionBlock) {
        let stringToken = String(describing: KeychainWrapper.standard.string(forKey: "token") ?? "" )
        let headers : HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(stringToken)"]
        
        AF.request(urlStr, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let jsonString = String(data: response.data!, encoding: .utf8)
                        let profileProductComment = try ProfileProductComment(jsonString!)
                        completion(profileProductComment, nil )
                    }
                    catch let e {
                        completion(nil, e.localizedDescription)
                    }
                    
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
    
    static func sendScanRequest(parameters: [String: Any],
                                completion: @escaping ScanRequestCompletionBlock) {
        
        let stringToken = String(describing: KeychainWrapper.standard.string(forKey: "token") ?? "" )
        let headers : HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(stringToken)"]
        
        AF.request("http://192.168.1.155:62755/api/user/scan", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let jsonString = String(data: response.data!, encoding: .utf8)
                        let scan = try Scan(jsonString!)
                        completion(scan, nil )
                    }
                    catch let e {
                        completion(nil, e.localizedDescription)
                    }
                    
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
    }
    
    static func sendCommentRequest(parameters: [String: Any],
                                   completion: @escaping RequestCompletionBlock) {
        let stringToken = String(describing: KeychainWrapper.standard.string(forKey: "token") ?? "" )
        let headers : HTTPHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(stringToken)"]
        AF.request("http://192.168.1.155:62755/api/product/comment", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                case .success(let responseObject):
                    completion(responseObject as? [String : Any], nil)
                }
            }
    }
}
