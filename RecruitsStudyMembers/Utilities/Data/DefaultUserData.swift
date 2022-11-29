//
//  DefaultUserData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import Foundation

struct DefaultUserData: Hashable {
    let data: UserData?
    private let identifier = UUID()
    
    static func callOne() -> [DefaultUserData] {
        return [DefaultUserData(data: NetworkManager.shared.userData)]
    }
    
    static func callTwo() -> [DefaultUserData] {
        return [DefaultUserData(data: NetworkManager.shared.userData),
                DefaultUserData(data: NetworkManager.shared.userData)]
    }
}


struct MemberListData: Hashable {
    let data: FromQueueDB
    private let identifier = UUID()
}
