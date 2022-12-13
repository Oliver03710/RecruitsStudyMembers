//
//  ChatRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/07.
//

import Foundation

import Alamofire

enum SeSacApiChat {
    case chatGet, chatPost
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
        case .chatGet: return UserDefaultsManager.chatGet + "/\(NetworkManager.shared.uid)"
        case .chatPost: return UserDefaultsManager.chatPost + "/\(NetworkManager.shared.uid)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .chatGet: return .get
        case .chatPost: return .post
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .chatGet, .chatPost: return ["Content-Type": UserDefaultsManager.contentType,
                                          "idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .chatPost: return ["chat": NetworkManager.shared.myChat]
        case .chatGet: return ["lastchatDate": NetworkManager.shared.lastChatDate]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .chatGet, .chatPost: return URLEncoding.default
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
