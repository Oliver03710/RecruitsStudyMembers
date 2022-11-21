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
                DummyData(backgroundImage: BackgroundImages.sesacBackground1.rawValue,foregroundImage: FaceImages.sesacFace1.rawValue , name: "김새싹", title: "타이틀"),
                DummyData(backgroundImage: BackgroundImages.sesacBackground1.rawValue,foregroundImage: FaceImages.sesacFace1.rawValue , name: "김새싹", title: "타이틀")]
    }

}
