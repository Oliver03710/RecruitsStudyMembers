//
//  CustomError.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/13.
//

import Foundation

protocol NetworkStatus: Error {
    
}

enum SesacStatus {
    
    enum User {
        enum SignUpSuccess: Int, NetworkStatus {
            case success = 200
            case existUser = 201
            case invalidNickname = 202
        }
    }
    
    enum Queue {
        enum FindRequest: Int, NetworkStatus {
            case success = 200
            case reportedOver3Times = 201
            case studyCancelPanaltyLv1 = 203
            case studyCancelPanaltyLv2 = 204
            case studyCancelPanaltyLv3 = 205
        }
        
        enum CancelFindRequest: Int, NetworkStatus {
            case success = 200
            case requestCanceled = 201
        }
        
        enum myQueueState: Int, NetworkStatus {
            case success = 200
            case defaultState = 201
        }
        
        enum StudyRequest: Int, NetworkStatus {
            case success = 200
            case alreadyReceivedRequest = 201
            case userCanceledSeeking = 202
        }
        
        enum AcceptStudyRequest: Int, NetworkStatus {
            case success = 200
            case userAlreadyMatched = 201
            case userCanceledSeeking = 202
            case meAlreadyMatched = 203
        }
        
        enum Dodge: Int, NetworkStatus {
            case success = 200
            case wrongUid = 201
        }
    }
    
    enum DefaultSuccess: Int, NetworkStatus {
        case success = 200
    }

    enum DefaultError: Int, NetworkStatus {
        case firebase = 401
        case unsignedUp = 406
        case server = 500
        case client = 501
    }
}


// MARK: - Extension: Default Error Descriptions

extension SesacStatus.DefaultError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .firebase: return "파이어베이스 토큰 만료."
        case .unsignedUp: return "미가입 유저입니다. 회원가입 화면으로 이동합니다."
        case .server: return "서버에 문제가 있으니 잠시 후 다시 요청바랍니다."
        case .client: return "잘못된 요청입니다."
        }
    }
}

// MARK: - Extension: User Success States Descriptions

extension SesacStatus.User.SignUpSuccess: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .existUser: return "이미 가입된 유저입니다."
        case .invalidNickname: return "사용할 수 없는 닉네임입니다. 닉네임을 다시 생성해주세요."
        }
    }
}

// MARK: - Extension: Queue Success States Descriptions

extension SesacStatus.Queue.FindRequest: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .reportedOver3Times: return "신고를 세번 이상 당한 유저입니다."
        case .studyCancelPanaltyLv1: return "스터디 취소 패널티 1단계입니다."
        case .studyCancelPanaltyLv2: return "스터디 취소 패널티 2단계입니다."
        case .studyCancelPanaltyLv3: return "스터디 취소 패널티 3단계입니다."
        }
    }
}

extension SesacStatus.Queue.CancelFindRequest: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .requestCanceled: return "이미 매칭된 상태"
        }
    }
}

extension SesacStatus.Queue.myQueueState: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .defaultState: return "일반 상태"
        }
    }
}

extension SesacStatus.Queue.StudyRequest: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .alreadyReceivedRequest: return "이미 요청을 받았습니다."
        case .userCanceledSeeking: return "상대방이 새싹 찾기를 중단한 상태입니다."
        }
    }
}

extension SesacStatus.Queue.AcceptStudyRequest: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .userAlreadyMatched: return "상대방이 이미 매칭된 상태입니다."
        case .userCanceledSeeking: return "상대방이 새싹 찾기를 중단한 상태입니다."
        case .meAlreadyMatched: return "이미 다른 유저와 매칭된 상태입니다."
        }
    }
}

extension SesacStatus.Queue.Dodge: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .success: return "성공"
        case .wrongUid: return "잘못된 UID 요청"
        }
    }
}


