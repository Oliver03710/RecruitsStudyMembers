//
//  GenderButtonOnMap.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/20.
//

import UIKit

final class GenderButtonOnMap: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, isSelected: Bool = false) {
        self.init()
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont(name: isSelected ? SSFonts.title3M14.fonts : SSFonts.title4R14.fonts, size: isSelected ? SSFonts.title3M14.size : SSFonts.title4R14.size)
        backgroundColor = isSelected ? SSColors.green.color : SSColors.white.color
        setTitleColor(isSelected ? SSColors.white.color : SSColors.black.color, for: .normal)
    }
    
}
