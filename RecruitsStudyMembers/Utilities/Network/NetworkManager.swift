//
//  NetworkManager.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import Alamofire
import FirebaseAuth
import RxCocoa
import RxSwift

final class NetworkManager {
    
    // MARK: - Properties
    
    var userData: UserData = UserData(id: "", v: 0, uid: "", phoneNumber: "", email: "", fcMtoken: "", nick: "", birth: "", gender: 0, study: "", comment: [], reputation: [], sesac: 0, sesacCollection: [], background: 0, backgroundCollection: [], purchaseToken: [], transactionID: [], reviewedBefore: [], reportedNum: 0, reportedUser: [], dodgepenalty: 0, dodgeNum: 0, ageMin: 0, ageMax: 0, searchable: 0, createdAt: "")
    
    var nearByStudyList: [SearchView.Item] = []
    var myStudyList: [SearchView.Item] = []
    
    var uid = ""
    var myChat = ""
    var lastChatDate = ""
    var nickName = ""
    
    var moreViewState = AlertSplit.report
    var popupPresented = false
    
    var reviewArr = Array<Int>(repeating: 0, count: 8)
    
    var queueState = BehaviorRelay<QueueStates>(value: .defaultState)
    
    static let shared = NetworkManager()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    private init() { }
    
    
    // MARK: - Helper Functions
        
    func request<T: Codable>(_ types: T.Type = T.self, router: URLRequestConvertible) -> Single<(data: T, state: Int)> {
        return Single<(data: T, state: Int)>.create { single in

            AF.request(router).responseDecodable(of: types.self) { response in

                guard let statusCode = response.response?.statusCode else { return }
                
                switch response.result {
                case .success(let value):
                        let dataWithState = (value, statusCode)
                        single(.success(dataWithState))
                    
                case .failure:
                    guard let error = SesacStatus.DefaultError(rawValue: statusCode) else { return }
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func request(router: URLRequestConvertible) -> Single<(data: String, state: Int)> {
        return Single<(data: String, state: Int)>.create { single in
            
            AF.request(router).responseString() { response in
                
                guard let statusCode = response.response?.statusCode else { return }
                
                switch response.result {
                case .success(let value):
                    let dataWithState = (value, statusCode)
                    single(.success(dataWithState))
                    
                case .failure:
                    guard let error = SesacStatus.DefaultError(rawValue: statusCode) else { return }
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
    
    func fireBaseError(competionHandler: @escaping () -> Void, errorHandler: @escaping () -> Void) {
        guard let codeNum = NetworkManager.shared.refreshToken() else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                competionHandler()
            }
            return
        }
        guard let errorCode = AuthErrorCode.Code(rawValue: codeNum) else { return }
        switch errorCode {
        default: errorHandler()
        }
    }
}
