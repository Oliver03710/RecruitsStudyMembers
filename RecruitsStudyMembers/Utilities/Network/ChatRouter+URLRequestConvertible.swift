//
//  ChatRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/07.
//

import Foundation

import Alamofire

enum SeSacApiChat {
    case chatGet, chatPost, ChatSignUp
}


// MARK: - Extension: URLRequestConvertible

extension SeSacApiChat: URLRequestConvertible {
    
    // MARK: - Properties
    
    var url: URL {
        switch self {
        default:
            guard let url = URL(string: UserDefaultsManager.chatBaseURLPath) else { return URL(fileURLWithPath: "") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .chatGet, .ChatSignUp: return UserDefaultsManager.chatGet
        case .chatPost: return UserDefaultsManager.chatSignUp
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatGet, .ChatSignUp: return .get
        case .chatPost: return .post
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .chatGet, .chatPost: return ["Content-Type": UserDefaultsManager.jsonContentType,
                                          "Authorization": "Bearer \(UserDefaultsManager.token)"]
            
        case .ChatSignUp: return ["Content-Type": UserDefaultsManager.jsonContentType]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .chatPost: return ["text": "시험 텍스트"]
        case .ChatSignUp: return ["username" : "고래밥",
                                  "password" : "12345678",
                                  "name" : "고래밥",
                                  "email" : "jack4@jack.com",
                                  "url" : "https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"]
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .chatGet, .chatPost, .ChatSignUp: return JSONEncoding.default
        }
    }
    
    
    // MARK: - Helper Functions
    
    func asURLRequest() throws -> URLRequest {
        
        let url = url.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        return try JSONEncoding.default.encode(urlRequest, with: parameters)
    }
}
