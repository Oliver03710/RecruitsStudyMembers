//
//  QueueRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

import Alamofire

enum SeSacApiQueue {
    case myQueueState, search, queue, sendRequest, cancelRequest, acceptRequest, dodge, rate
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
        case .acceptRequest: return UserDefaultsManager.studyAccept
        case .dodge: return UserDefaultsManager.dodge
        case .rate: return UserDefaultsManager.rate + "/\(NetworkManager.shared.uid)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .myQueueState: return .get
        case .search, .queue, .sendRequest, .acceptRequest, .dodge, .rate: return .post
        case .cancelRequest: return .delete
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .cancelRequest, .myQueueState: return ["idtoken": UserDefaultsManager.token]
            
        case .search, .queue, .sendRequest, .acceptRequest, .dodge, .rate:
            return ["Content-Type": UserDefaultsManager.contentType,
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
            
        case .sendRequest, .acceptRequest, .dodge: return ["otheruid": NetworkManager.shared.uid]
            
        case .rate: return ["otheruid": NetworkManager.shared.uid,
                            "comment": NetworkManager.shared.reviewComment,
                            "reputation": NetworkManager.shared.reviewArr]
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .myQueueState, .search, .sendRequest, .cancelRequest, .acceptRequest, .dodge: return URLEncoding.default
        case .queue, .rate: return URLEncoding(arrayEncoding: .noBrackets)
        }
    }
    
    
    // MARK: - Helper Functions
    
    func asURLRequest() throws -> URLRequest {
        
        let url = url.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = headers
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
