//
//  QueueRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

import Alamofire

enum SeSacApiQueue {
    case myQueueState, search
}


// MARK: - Extension: URLRequestConvertible

extension SeSacApiQueue: URLRequestConvertible {
    
    // MARK: - Properties
    
    var url: URL {
        switch self {
        default:
            guard let url = URL(string: UserDefaultsManager.queueBaseURLPath) else { return URL(fileURLWithPath: "") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .myQueueState: return UserDefaultsManager.myQueueState
        case .search: return UserDefaultsManager.search
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .myQueueState: return .get
        case .search: return .post
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .myQueueState: return ["idtoken": UserDefaultsManager.token]
        case .search: return ["Content-Type": UserDefaultsManager.contentType,
                              "idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: String]? {
        switch self {
        case .search: return ["lat": "\(LocationManager.shared.currentPosition.lat)",
                              "long": "\(LocationManager.shared.currentPosition.lon)"]
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .myQueueState, .search: return URLEncoding.default
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
