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


struct DummyItem: Hashable {
    
    let text: String?
    private let identifier = UUID()
    
    static func callDummy() -> [DummyItem] {
        return [DummyItem(text: "Swift"),
                DummyItem(text: "SwiftUI"),
                DummyItem(text: "CoreData"),
                DummyItem(text: "Python"),
                DummyItem(text: "Java")]
    }
    
    static func baseDummy() -> [DummyItem] {
        return [DummyItem(text: "아무거나"),
                DummyItem(text: "SeSAC"),
                DummyItem(text: "코딩")]
    }
}
