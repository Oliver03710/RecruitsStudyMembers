//
//  SSImages.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

enum BackgroundImages: Int, CaseIterable {
    case sesacBackground0
    case sesacBackground1
    case sesacBackground2
    case sesacBackground3
    case sesacBackground4
    case sesacBackground5
    case sesacBackground6
    case sesacBackground7
    case sesacBackground8
    
    var images: UIImage? {
        switch self {
        case .sesacBackground0: return UIImage(named: "sesacBackground0")
        case .sesacBackground1: return UIImage(named: "sesacBackground1")
        case .sesacBackground2: return UIImage(named: "sesacBackground2")
        case .sesacBackground3: return UIImage(named: "sesacBackground3")
        case .sesacBackground4: return UIImage(named: "sesacBackground4")
        case .sesacBackground5: return UIImage(named: "sesacBackground5")
        case .sesacBackground6: return UIImage(named: "sesacBackground6")
        case .sesacBackground7: return UIImage(named: "sesacBackground7")
        case .sesacBackground8: return UIImage(named: "sesacBackground8")
        }
    }
    
    var title: String? {
        switch self {
        case .sesacBackground0: return "하늘 공원"
        case .sesacBackground1: return "씨티 뷰"
        case .sesacBackground2: return "밤의 산책로"
        case .sesacBackground3: return "낮의 산책로"
        case .sesacBackground4: return "연극 무대"
        case .sesacBackground5: return "라틴 거실"
        case .sesacBackground6: return "홈트방"
        case .sesacBackground7: return "뮤지션 작업실"
        case .sesacBackground8: return "악마의 공방"
        }
    }
    
    var price: String {
        switch self {
        case .sesacBackground0: return "보유"
        case .sesacBackground1: return "1,200"
        case .sesacBackground2: return "1,200"
        case .sesacBackground3: return "1,200"
        case .sesacBackground4: return "2,500"
        case .sesacBackground5: return "2,500"
        case .sesacBackground6: return "2,500"
        case .sesacBackground7: return "2,500"
        case .sesacBackground8: return "2,500"
        }
    }
    
    var description: String? {
        switch self {
        case .sesacBackground0: return "새싹들을 많이 마주치는 매력적인 하늘 공원입니다."
        case .sesacBackground1: return "창밖으로 보이는 도시 야경이 아름다운 공간입니다."
        case .sesacBackground2: return "어둡지만 무섭지 않은 조용한 산책로입니다."
        case .sesacBackground3: return "즐겁고 가볍게 걸을 수 있는 산책로입니다"
        case .sesacBackground4: return "연극의 주인공이 되어 연기를 펼칠 수 있는 무대입니다."
        case .sesacBackground5: return "모노톤의 따스한 감성의 거실로 편하게 쉴 수 있는 공간입니다."
        case .sesacBackground6: return "집에서 운동을 할 수 있도록 기구를 갖춘 방입니다."
        case .sesacBackground7: return "여러가지 음악 작업을 할 수 있는 작업실입니다."
        case .sesacBackground8: return "악마들이 도자기를 만드는 공방입니다."
        }
    }

}

enum FaceImages: Int, CaseIterable {
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
    
    var title: String? {
        switch self {
        case .sesacFace0: return "기본 새싹"
        case .sesacFace1: return "튼튼 새싹"
        case .sesacFace2: return "민트 새싹"
        case .sesacFace3: return "퍼플 새싹"
        case .sesacFace4: return "골드 새싹"
        }
    }
    
    var price: String {
        switch self {
        case .sesacFace0: return "보유"
        case .sesacFace1: return "1,200"
        case .sesacFace2: return "2,500"
        case .sesacFace3: return "2,500"
        case .sesacFace4: return "2,500"
        }
    }
    
    var description: String? {
        switch self {
        case .sesacFace0: return "새싹을 대표하는 기본 식물입니다. 다른 새싹들과 함께 하는 것을 좋아합니다."
        case .sesacFace1: return "잎이 하나 더 자라나고 튼튼해진 새나라의 새싹으로 같이 있으면 즐거워집니다."
        case .sesacFace2: return "호불호의 대명사! 상쾌한 향이 나서 허브가 대중화된 지역에서 많이 자랍니다."
        case .sesacFace3: return "감정을 편안하게 쉬도록 하며 슬프고 우울한 감정을 진정시켜주는 멋진 새싹입니다."
        case .sesacFace4: return "화려하고 멋있는 삶을 살며 돈과 인생을 플렉스 하는 자유분방한 새싹입니다."
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
