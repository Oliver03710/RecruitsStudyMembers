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
    case signup
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
        case .signup: return UserDefaultsManager.signupPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .get
        case .signup: return .post
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .login: return ["Content-Type": UserDefaultsManager.contentType, "idtoken": UserDefaultsManager.token]
        case .signup: return ["Content-Type": UserDefaultsManager.contentType, "idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .signup: return ["phoneNumber": UserDefaultsManager.phoneNum,
                              "FCMtoken": UserDefaultsManager.fcmToken,
                              "nick": UserDefaultsManager.nickname,
                              "birth": UserDefaultsManager.birth,
                              "email": UserDefaultsManager.email,
                              "gender": "\(UserDefaultsManager.gender)"]
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login: return URLEncoding.default
        case .signup: return URLEncoding.default
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
