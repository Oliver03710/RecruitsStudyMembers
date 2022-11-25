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
    
    var userData: UserData = UserData(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "", nick: "", birth: "", gender: 0, study: "", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [], transactionID: [], reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0, ageMax: 0, searchable: 0, createdAt: "")
    
    static let shared = NetworkManager()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    private init() { }
    
    
    // MARK: - Helper Functions
        
    func request<T: Codable>(_ types: T.Type = T.self, router: URLRequestConvertible) -> Single<T> {
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
    
    func request(router: URLRequestConvertible) -> Single<String> {
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
    
    func saveUserData(data: UserData) {
        userData = data
    }
    
    func fireBaseError(competionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void, defaultErrorHandler: @escaping () -> Void) {
        guard let codeNum = NetworkManager.shared.refreshToken() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                competionHandler()
            }
            return
        }
        guard let errorCode = AuthErrorCode.Code(rawValue: codeNum) else { return }
        switch errorCode {
        case .tooManyRequests:
            errorHandler()
        default:
            defaultErrorHandler()
        }
    }
}


