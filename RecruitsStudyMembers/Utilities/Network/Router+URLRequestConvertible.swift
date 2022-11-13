//
//  Router+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import Alamofire

enum SeSacApi {
    case login
}


// MARK: - Extension: URLRequestConvertible

extension SeSacApi: URLRequestConvertible {
    
    // MARK: - Properties
    
    var url: URL {
        switch self {
        default:
            guard let url = URL(string: UserDefaultsManager.baseURLPath) else { return URL(fileURLWithPath: "") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .login: return UserDefaultsManager.loginPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .get
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .login: return ["Content-Type": UserDefaultsManager.contentType, "idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login: return URLEncoding.default
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
