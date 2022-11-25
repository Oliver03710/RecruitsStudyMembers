//
//  QueueRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

import Alamofire

enum SeSacApiQueue {
    case myQueueState
}


// MARK: - Extension: URLRequestConvertible

extension SeSacApiQueue: URLRequestConvertible {
    
    // MARK: - Properties
    
    var url: URL {
        switch self {
        default:
            guard let url = URL(string: UserDefaultsManager.userBaseURLPath) else { return URL(fileURLWithPath: "") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .myQueueState: return UserDefaultsManager.myQueueState
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .myQueueState: return .get
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .myQueueState: return ["idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .myQueueState: return JSONEncoding.default
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
