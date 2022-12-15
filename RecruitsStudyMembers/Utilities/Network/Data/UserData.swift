//
//  UserData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/13.
//

import Foundation

struct UserData: Codable, Hashable {
    var id: String
    var v: Int
    var uid, phoneNumber, email, fcMtoken: String
    var nick, birth: String
    var gender: Int
    var study: String
    var comment: [String]
    var reputation: [Int]
    var sesac: Int
    var sesacCollection: [Int]
    var background: Int
    var backgroundCollection: [Int]
    var purchaseToken, transactionID, reviewedBefore: [String]
    var reportedNum: Int
    var reportedUser: [String]
    var dodgepenalty, dodgeNum, ageMin, ageMax: Int
    var searchable: Int
    var createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case uid, phoneNumber, email
        case fcMtoken = "FCMtoken"
        case nick, birth, gender, study, comment, reputation, sesac, sesacCollection, background, backgroundCollection, purchaseToken
        case transactionID = "transactionId"
        case reviewedBefore, reportedNum, reportedUser, dodgepenalty, dodgeNum, ageMin, ageMax, searchable, createdAt
    }
}
