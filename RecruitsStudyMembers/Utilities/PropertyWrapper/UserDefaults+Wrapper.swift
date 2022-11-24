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
    @UserDefaultsWrapper(key: "baseURLPath", defaultValue: "http://api.sesac.co.kr:1210")
    static var baseURLPath: String
    
    @UserDefaultsWrapper(key: "contentType", defaultValue: "application/x-www-form-urlencoded")
    static var contentType: String
    
    @UserDefaultsWrapper(key: "loginPath", defaultValue: "/v1/user")
    static var loginPath: String
    
    @UserDefaultsWrapper(key: "signupPath", defaultValue: "/v1/user")
    static var signupPath: String
    
    @UserDefaultsWrapper(key: "myPagePath", defaultValue: "/v1/user/mypage")
    static var myPagePath: String
    
    @UserDefaultsWrapper(key: "withdrawPath", defaultValue: "/v1/user/withdraw")
    static var withdrawPath: String
    
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
