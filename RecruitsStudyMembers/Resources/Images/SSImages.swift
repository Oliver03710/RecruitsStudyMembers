//
//  SSImages.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

enum BackgroundImages: Int {
    case sesacBackground0
    case sesacBackground1
    case sesacBackground2
    case sesacBackground3
    case sesacBackground4
    case sesacBackground5
    case sesacBackground6
    case sesacBackground7
    case sesacBackground8
}

enum FaceImages: Int {
    case sesacFace0
    case sesacFace1
    case sesacFace2
    case sesacFace3
    case sesacFace4
    
    var images: UIImage? {
        switch self {
        case .sesacFace0: return UIImage(named: "sesacFace0")
        case .sesacFace1: return UIImage(named: "sesacFace1")
        case .sesacFace2: return UIImage(named: "sesacFace2")
        case .sesacFace3: return UIImage(named: "sesacFace3")
        case .sesacFace4: return UIImage(named: "sesacFace4")
        }
    }
}

enum SplashImages: String {
    case splashLogo
    case splashText
}

enum OnboardingImages: String {
    case onboardingImg1
    case onboardingImg2
    case onboardingImg3
}
