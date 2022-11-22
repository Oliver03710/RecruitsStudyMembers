//
//  DummyData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import Foundation

struct DummyData: Hashable {
    let backgroundImage: String?
    let foregroundImage: String?
    let name: String?
    let title: String?
    private let identifier = UUID()
    
    static func callDummy() -> [DummyData] {
        return [DummyData(backgroundImage: BackgroundImages.sesacBackground1.rawValue,foregroundImage: FaceImages.sesacFace1.rawValue , name: "김새싹", title: nil)]
    }
    
    static func diffDummy() -> [DummyData] {
        return [DummyData(backgroundImage: BackgroundImages.sesacBackground1.rawValue,foregroundImage: FaceImages.sesacFace1.rawValue , name: "김새싹", title: nil),
                DummyData(backgroundImage: BackgroundImages.sesacBackground1.rawValue,foregroundImage: FaceImages.sesacFace1.rawValue , name: "김새싹", title: "타이틀")]
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
