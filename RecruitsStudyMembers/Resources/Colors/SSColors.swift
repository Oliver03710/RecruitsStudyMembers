//
//  Colors.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/07.
//

import UIKit

enum SSColors {
    case white, black, green, whiteGreen, yellowGreen, gray1, gray2, gray3, gray4, gray5, gray6, gray7, success, error, focus
    
    var color: UIColor {
        switch self {
        case .white: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .black: return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        case .green: return #colorLiteral(red: 0.2862745098, green: 0.862745098, blue: 0.5725490196, alpha: 1)
        case .whiteGreen: return #colorLiteral(red: 0.8039215686, green: 0.9568627451, blue: 0.8823529412, alpha: 1)
        case .yellowGreen: return #colorLiteral(red: 0.6980392157, green: 0.9215686275, blue: 0.3803921569, alpha: 1)
        case .gray1: return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        case .gray2: return #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        case .gray3: return #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        case .gray4: return #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
        case .gray5: return #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        case .gray6: return #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        case .gray7: return #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        case .success: return #colorLiteral(red: 0.3843137255, green: 0.5607843137, blue: 0.9019607843, alpha: 1)
        case .error: return #colorLiteral(red: 0.9137254902, green: 0.4, blue: 0.4196078431, alpha: 1)
        case .focus: return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        }
    }
}
