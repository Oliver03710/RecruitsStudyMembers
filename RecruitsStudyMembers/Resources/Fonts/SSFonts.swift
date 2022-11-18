//
//  SSFonts.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/07.
//

import UIKit

enum SSFonts {
    case display1R20
    case title1M16
    case title2R16
    case title3M14
    case title4R14
    case title5M12
    case title6R12
    case body1M16
    case body2R16
    case body3R14
    case body4R12
    case captionR10
    
    var fonts: String {
        switch self {
        case .display1R20, .title2R16, .title4R14, .title6R12, .body2R16, .body3R14, .body4R12, .captionR10:
            return "NotoSansCJKkr-Regular"
        case .title1M16, .title3M14, .title5M12, .body1M16:
            return "NotoSansCJKkr-Medium"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .display1R20:
            return 20
        case .title1M16, .title2R16, .body1M16, .body2R16:
            return 16
        case .title3M14, .title4R14, .body3R14:
            return 14
        case .title5M12, .title6R12, .body4R12:
            return 12
        case .captionR10:
            return 10
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .display1R20, .title1M16, .title2R16, .title3M14, .title4R14, .captionR10:
            return 1.6
        case .title5M12, .title6R12:
            return 1.5
        case .body1M16, .body2R16:
            return 1.85
        case .body3R14:
            return 1.7
        case .body4R12:
            return 1.8
        }
    }
    
}

