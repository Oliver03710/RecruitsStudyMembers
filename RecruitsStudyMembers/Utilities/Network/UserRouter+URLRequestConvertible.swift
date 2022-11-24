//
//  UserRouter+URLRequestConvertible.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import Alamofire

enum SeSacApiUser {
    case login, signup, myPage, withdraw
}


// MARK: - Extension: URLRequestConvertible

extension SeSacApiUser: URLRequestConvertible {
    
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
        case .login, .signup: return UserDefaultsManager.loginAndSignupPath
        case .myPage: return UserDefaultsManager.myPagePath
        case .withdraw: return UserDefaultsManager.withdrawPath
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login: return .get
        case .signup, .withdraw: return .post
        case .myPage: return .put
        }
    }
        
    var headers: HTTPHeaders {
        switch self {
        case .login, .signup, .myPage: return ["Content-Type": UserDefaultsManager.contentType, "idtoken": UserDefaultsManager.token]
        case .withdraw: return ["idtoken": UserDefaultsManager.token]
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
            
        case .myPage: return ["searchable": "\(NetworkManager.shared.userData.searchable)",
                              "ageMin": "\(NetworkManager.shared.userData.ageMin)",
                              "ageMax": "\(NetworkManager.shared.userData.ageMax)",
                              "gender": "\(NetworkManager.shared.userData.gender)",
                              "study": "\(NetworkManager.shared.userData.study)"]
        default: return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .login, .signup, .myPage, .withdraw: return URLEncoding.default
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
