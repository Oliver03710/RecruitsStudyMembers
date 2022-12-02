//
//  QueueRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

import Alamofire

enum SeSacApiQueue {
    case myQueueState, search, queue, sendRequest, cancelRequest
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
        case .queue, .cancelRequest: return ""
        case .sendRequest: return UserDefaultsManager.studyRequest
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .myQueueState: return .get
        case .search, .queue, .sendRequest: return .post
        case .cancelRequest: return .delete
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .myQueueState, .cancelRequest: return ["idtoken": UserDefaultsManager.token]
        case .search, .queue, .sendRequest: return ["Content-Type": UserDefaultsManager.contentType,
                                      "idtoken": UserDefaultsManager.token]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .search: return ["lat": "\(LocationManager.shared.currentPosition.lat)",
                              "long": "\(LocationManager.shared.currentPosition.lon)"]
            
        case .queue:
            var arr = Array<String>()
            NetworkManager.shared.myStudyList.forEach { item in
                arr.append(item.title)
            }
            
            if arr.isEmpty {
                arr.append("Anything")
            }
            
            return ["lat": "\(LocationManager.shared.currentPosition.lat)",
                    "long": "\(LocationManager.shared.currentPosition.lon)",
                    "studylist": arr]
            
        case .sendRequest: return ["otheruid": NetworkManager.shared.uid]
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .myQueueState, .search, .sendRequest, .cancelRequest: return URLEncoding.default
        case .queue: return URLEncoding(arrayEncoding: .noBrackets)
        }
    }
    
    
    // MARK: - Helper Functions
    
    func asURLRequest() throws -> URLRequest {
        
        let url = url.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        return try URLEncoding(arrayEncoding: .noBrackets).encode(urlRequest, with: parameters)
    }
}
