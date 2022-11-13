//
//  CustomError.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/13.
//

import Foundation

enum SeSacError: Int, Error {
    case firebaseTokenError = 401
    case unsignedupUser = 406
    case ServerError = 500
    case ClientError = 501
}

extension SeSacError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .firebaseTokenError: return "토큰이 만료되었습니다. 토큰을 재발급 받아주세요."
        case .unsignedupUser: return "미가입된 유저입니다. 회원가입 창으로 이동합니다."
        case .ServerError: return "서버 에러"
        case .ClientError: return "클라이언트 에러"
        }
    }
}

