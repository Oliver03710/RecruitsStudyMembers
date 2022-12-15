//
//  SeSacApiShop+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import Foundation

import Alamofire

enum SeSacApiShop {
    case checkMyInfo
}


// MARK: - Extension: URLRequestConvertible

extension SeSacApiShop: URLRequestConvertible {
    
    // MARK: - Properties
    
    var url: URL {
        switch self {
        default:
            guard let url = URL(string: UserDefaultsManager.shopBaseURLPath) else { return URL(fileURLWithPath: "") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .checkMyInfo: return UserDefaultsManager.checkMyInfo
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .checkMyInfo: return .get
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .checkMyInfo: return ["idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .checkMyInfo: return URLEncoding.default
        }
    }
    
    
    // MARK: - Helper Functions
    
    func asURLRequest() throws -> URLRequest {
        
        let url = url.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
