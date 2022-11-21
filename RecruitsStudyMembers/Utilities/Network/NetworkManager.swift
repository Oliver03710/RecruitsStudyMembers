//
//  NetworkManager.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import Alamofire
import FirebaseAuth
import RxSwift

final class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    
    // MARK: - Init
    
    private init() { }
    
    
    // MARK: - Helper Functions
        
    func request<T: Codable>(_ types: T.Type = T.self, router: SeSacApi) -> Single<T> {
        return Single<T>.create { single in

            AF.request(router).validate(statusCode: 200..<400).responseDecodable(of: types.self) { response in

                switch response.result {
                case .success(let value):
                    single(.success(value))
                case .failure:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSacError(rawValue: statusCode) else { return }
                    single(.failure(error))
                }

            }
            return Disposables.create()
        }
    }
    
    func request(router: SeSacApi) -> Single<String> {
        return Single<String>.create { single in
            
            AF.request(router).validate(statusCode: 100...200).responseString() { response in
                switch response.result {
                case .success(let data):
                    single(.success(data))
                case .failure:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = SeSacError(rawValue: statusCode) else { return }
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func refreshToken() -> Int? {
        let currentUser = Auth.auth().currentUser
        var errCode: Int? = nil
        
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error as NSError? {
                errCode = error.code
                return
            }
            
            guard let token = idToken else { return }
            UserDefaultsManager.token = token
            return
        }
        return errCode
    }
}


