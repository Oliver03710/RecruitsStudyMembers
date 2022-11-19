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
    
    convenience init(text: String, textColor: UIColor? = SSColors.black.color) {
        self.init()
        setTitle(text, for: .normal)
        backgroundColor = SSColors.white.color
        setTitleColor(textColor, for: .normal)
    }
    
}
