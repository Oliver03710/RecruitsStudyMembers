//
//  UserDefaults+Wrapper.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults

    var wrappedValue: T {
        get { self.storage.object(forKey: self.key) as? T ?? self.defaultValue }
        set { self.storage.set(newValue, forKey: self.key) }
    }
    
    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}

struct UserDefaultsManager {
    
    // MARK: - Token
    @UserDefaultsWrapper(key: "token", defaultValue: "")
    static var token: String
    
    @UserDefaultsWrapper(key: "verificationID", defaultValue: "")
    static var verificationID: String
    
    @UserDefaultsWrapper(key: "certiNum", defaultValue: "")
    static var certiNum: String
    
    @UserDefaultsWrapper(key: "fcmToken", defaultValue: "")
    static var fcmToken: String
    
    // MARK: - API
    @UserDefaultsWrapper(key: "contentType", defaultValue: "application/x-www-form-urlencoded")
    static var contentType: String
    
    @UserDefaultsWrapper(key: "jsonContentType", defaultValue: "application/json")
    static var jsonContentType: String
    
    // MARK: - User API
    @UserDefaultsWrapper(key: "userBaseURLPath", defaultValue: "http://api.sesac.co.kr:1210/v1/user")
    static var userBaseURLPath: String
    
    @UserDefaultsWrapper(key: "loginAndSignupPath", defaultValue: "")
    static var loginAndSignupPath: String
    
    @UserDefaultsWrapper(key: "myPagePath", defaultValue: "/mypage")
    static var myPagePath: String
    
    @UserDefaultsWrapper(key: "withdrawPath", defaultValue: "/withdraw")
    static var withdrawPath: String
    
    // MARK: - Queue API
    @UserDefaultsWrapper(key: "queueBaseURLPath", defaultValue: "http://api.sesac.co.kr:1210/v1/queue")
    static var queueBaseURLPath: String
    
    @UserDefaultsWrapper(key: "requestAndStop", defaultValue: "")
    static var requestAndStop: String
    
    @UserDefaultsWrapper(key: "search", defaultValue: "/search")
    static var search: String
    
    @UserDefaultsWrapper(key: "myQueueState", defaultValue: "/myQueueState")
    static var myQueueState: String
    
    @UserDefaultsWrapper(key: "studyRequest", defaultValue: "/studyrequest")
    static var studyRequest: String
    
    @UserDefaultsWrapper(key: "studyAccept", defaultValue: "/studyaccept")
    static var studyAccept: String
    
    @UserDefaultsWrapper(key: "dodge", defaultValue: "/dodge")
    static var dodge: String
    
    @UserDefaultsWrapper(key: "rate", defaultValue: "/rate")
    static var rate: String
    
    // MARK: - Chat API
    @UserDefaultsWrapper(key: "chatBaseURLPath", defaultValue: "http://api.sesac.co.kr:1210/v1")
    static var chatBaseURLPath: String
    
    @UserDefaultsWrapper(key: "chatGet", defaultValue: "/chat")
    static var chatGet: String
    
    @UserDefaultsWrapper(key: "chatPost", defaultValue: "/chat")
    static var chatPost: String
    
    @UserDefaultsWrapper(key: "myUid", defaultValue: "")
    static var myUid: String
    
    // MARK: - Chat API
    @UserDefaultsWrapper(key: "shopBaseURLPath", defaultValue: "http://api.sesac.co.kr:1210/v1/user/shop")
    static var shopBaseURLPath: String
    
    @UserDefaultsWrapper(key: "checkMyInfo", defaultValue: "/myinfo")
    static var checkMyInfo: String
    
    @UserDefaultsWrapper(key: "item", defaultValue: "/item")
    static var item: String
    
    @UserDefaultsWrapper(key: "ios", defaultValue: "/ios")
    static var ios: String
    
    @UserDefaultsWrapper(key: "purchaseItem", defaultValue: "/purchaseItem")
    static var purchaseItem: String
    
    // MARK: - Parameters
    @UserDefaultsWrapper(key: "phoneNum", defaultValue: "")
    static var phoneNum: String
    
    // MARK: - Splash View
    @UserDefaultsWrapper(key: "passOnboarding", defaultValue: false)
    static var passOnboarding: Bool
    
    // MARK: - Sign Up
    @UserDefaultsWrapper(key: "nickname", defaultValue: "")
    static var nickname: String
        
    @UserDefaultsWrapper(key: "birthYear", defaultValue: "")
    static var birthYear: String
    
    @UserDefaultsWrapper(key: "birthMonth", defaultValue: "")
    static var birthMonth: String
    
    @UserDefaultsWrapper(key: "birthDay", defaultValue: "")
    static var birthDay: String
    
    @UserDefaultsWrapper(key: "birth", defaultValue: "")
    static var birth: String
    
    @UserDefaultsWrapper(key: "email", defaultValue: "")
    static var email: String
    
    @UserDefaultsWrapper(key: "gender", defaultValue: 2)
    static var gender: Int
    
    @UserDefaultsWrapper(key: "maleSelected", defaultValue: false)
    static var maleSelected: Bool
    
    @UserDefaultsWrapper(key: "genderSelected", defaultValue: false)
    static var genderSelected: Bool
    
    // MARK: - Tab Names
    @UserDefaultsWrapper(key: "homeTabName", defaultValue: "홈")
    static var homeTabName: String
    
    @UserDefaultsWrapper(key: "shopTabName", defaultValue: "새싹샵")
    static var shopTabName: String
    
    @UserDefaultsWrapper(key: "friendsTabName", defaultValue: "새싹친구")
    static var friendsTabName: String
    
    @UserDefaultsWrapper(key: "MyinfoTabName", defaultValue: "내정보")
    static var MyinfoTabName: String
    
    // MARK: - My Page Tab
    @UserDefaultsWrapper(key: "userName", defaultValue: "이름")
    static var userName: String
    
    @UserDefaultsWrapper(key: "userImage", defaultValue: 0)
    static var userImage: Int
    
    static func removeAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
    static func resetSignupData() {
        UserDefaultsManager.nickname = ""
        UserDefaultsManager.birthYear = ""
        UserDefaultsManager.birthMonth = ""
        UserDefaultsManager.birthDay = ""
        UserDefaultsManager.birth = ""
        UserDefaultsManager.email = ""
        UserDefaultsManager.gender = 2
        UserDefaultsManager.maleSelected = false
        UserDefaultsManager.genderSelected = false
    }
}
