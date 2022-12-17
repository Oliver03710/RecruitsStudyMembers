//
//  IAPBundles.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/17.
//

import Foundation

enum FaceIAPBundles: String, CaseIterable {
    case sesacFace0 = ""
    case sesacFace1 = "com.memolease.sesac1.sprout1"
    case sesacFace2 = "com.memolease.sesac1.sprout2"
    case sesacFace3 = "com.memolease.sesac1.sprout3"
    case sesacFace4 = "com.memolease.sesac1.sprout4"
    
    var Bundles: [String] {
        var arr = Array<String>()
        FaceIAPBundles.allCases.forEach { arr.append($0.rawValue) }
        return arr
    }
}

enum BackgroundIAPBundles: String, CaseIterable {
    case sesacBackground0 = ""
    case sesacBackground1 = "com.memolease.sesac1.background1"
    case sesacBackground2 = "com.memolease.sesac1.background2"
    case sesacBackground3 = "com.memolease.sesac1.background3"
    case sesacBackground4 = "com.memolease.sesac1.background4"
    case sesacBackground5 = "com.memolease.sesac1.background5"
    case sesacBackground6 = "com.memolease.sesac1.background6"
    case sesacBackground7 = "com.memolease.sesac1.background7"
    
    var Bundles: [String] {
        var arr = Array<String>()
        BackgroundIAPBundles.allCases.forEach { arr.append($0.rawValue) }
        return arr
    }
}
