//
//  CustomError.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/13.
//

import Foundation

enum SeSacUserError: Int, Error {
    case alreadySignedup = 201
    case invalidNickname = 202
    case firebaseTokenError = 401
    case unsignedupUser = 406
    case ServerError = 500
    case ClientError = 501
}

extension SeSacUserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .alreadySignedup: return "이미 가입되어 있는 유저입니다."
        case .invalidNickname: return "사용할 수 없는 닉네임입니다. 닉네임을 다시 생성해주세요."
        case .firebaseTokenError: return "토큰이 만료되었습니다. 토큰을 재발급 받아주세요."
        case .unsignedupUser: return "미가입된 유저입니다. 회원가입 창으로 이동합니다."
        case .ServerError: return "서버 에러"
        case .ClientError: return "클라이언트 에러"
        }
    }
}

enum SeSacQueueError: Int, Error {
    case error201 = 201
    case error202 = 202
    case error203 = 203
    case error204 = 204
    case error205 = 205
    case firebaseTokenError = 401
    case unsignedupUser = 406
    case ServerError = 500
    case ClientError = 501
}

extension SeSacQueueError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .firebaseTokenError: return "토큰이 만료되었습니다. 토큰을 재발급 받아주세요."
        case .unsignedupUser: return "미가입된 유저입니다. 회원가입 창으로 이동합니다."
        case .ServerError: return "서버 에러"
        case .ClientError: return "클라이언트 에러"
        default: return "에러 발생"
        }
    }
}
